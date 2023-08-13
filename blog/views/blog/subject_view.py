from django.shortcuts import get_object_or_404, redirect

# Standard Python Library imports.
from functools import reduce
import operator

# Core Django imports.
from django.contrib import messages
from django.db.models import Q
from django.views.generic import (
    DetailView,
    ListView,
)


# Blog application imports.
from blog.models.subject_model import Subject
from blog.models.course_model import Course
from blog.forms.blog.comment_forms import CommentForm
from blog.models.room_model import Subject, Room

class SubjectRoomsListView(ListView):
    model = Room
    paginate_by = 12
    context_object_name = 'rooms'
    template_name = 'blog/subject/subject_rooms.html'

    def get_queryset(self):
        subject = get_object_or_404(Subject, slug=self.kwargs.get('slug'))
        return Room.objects.filter(subject=subject, status=Room.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(SubjectRoomsListView, self).get_context_data(**kwargs)
        subject = get_object_or_404(Subject, slug=self.kwargs.get('slug'))
        context['subject'] = subject
        return context
    
    
class SubjectListView(ListView):
    context_object_name = "subjects"
    paginate_by = 12
    queryset = Subject.objects.filter(status=Subject.PUBLISHED, deleted=False)
    template_name = "blog/subject/subject_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['subjects'] = Subject.objects.filter(approved=True)
        return context


class SubjectDetailView(DetailView):
    model = Course
    template_name = 'blog/subject/subject_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_subject {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_subjects'] = \
            Course.objects.filter(subject=self.object.subject, status=Subject.PUBLISHED).order_by('?')[:3]
        kwargs['subject'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class SubjectSearchListView(ListView):
    model = Subject
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/subject/subject_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the subject content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Subject.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Subject.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Subject.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(SubjectSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Subject.objects.filter(approved=True)
        return context


class TagSubjectsListView(ListView):
    """
        List subjects related to a tag.
    """
    model = Subject
    paginate_by = 12
    context_object_name = 'tag_subjects_list'
    template_name = 'blog/subject/tag_subjects_list.html'

    def get_queryset(self):
        """
            Filter Subjects by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_subjects_list = Subject.objects.filter(tags__name__in=[tag_name],
                                                       status=Subject.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_subjects_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_subjects_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_subjects_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['subjects'] = Subject.objects.filter(approved=True)
        return context
