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
from blog.models.course_model import Course
from blog.models.article_models import Article
from blog.forms.blog.comment_forms import CommentForm
from blog.models.subject_model import Course, Subject

class CourseSubjectListView(ListView):
    model = Subject
    paginate_by = 12
    context_object_name = 'subjects'
    template_name = 'blog/course/course_subjects.html'

    def get_queryset(self):
        course = get_object_or_404(Course, slug=self.kwargs.get('slug'))
        return Subject.objects.filter(course=course, status=Subject.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(CourseSubjectListView, self).get_context_data(**kwargs)
        course = get_object_or_404(Course, slug=self.kwargs.get('slug'))
        context['course'] = course
        return context
    
class CourseListView(ListView):
    context_object_name = "courses"
    paginate_by = 12
    queryset = Course.objects.filter(status=Course.PUBLISHED, deleted=False)
    template_name = "blog/course/course_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['articles'] = Article.objects.filter(approved=True)
        return context


class CourseDetailView(DetailView):
    model = Course
    template_name = 'blog/course/course_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_course {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_courses'] = \
            Course.objects.filter(article=self.object.article, status=Course.PUBLISHED).order_by('?')[:3]
        kwargs['course'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class CourseSearchListView(ListView):
    model = Course
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/course/course_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the course content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Course.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Course.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Course.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(CourseSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Article.objects.filter(approved=True)
        return context


class TagCoursesListView(ListView):
    """
        List courses related to a tag.
    """
    model = Course
    paginate_by = 12
    context_object_name = 'tag_courses_list'
    template_name = 'blog/course/tag_courses_list.html'

    def get_queryset(self):
        """
            Filter Courses by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_courses_list = Course.objects.filter(tags__name__in=[tag_name],
                                                       status=Course.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_courses_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_courses_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_courses_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['articles'] = Article.objects.filter(approved=True)
        return context
