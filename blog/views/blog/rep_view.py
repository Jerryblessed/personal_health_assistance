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
from blog.models.rep_model import Rep
from blog.models.room_model import Room
from blog.forms.blog.comment_forms import CommentForm

from blog.models.mem_model import Rep, Mem
from django.shortcuts import render

class RepMemsListView(ListView):
    model = Mem
    paginate_by = 12
    context_object_name = 'mems'
    template_name = 'blog/rep/rep_mems.html'
    def get_queryset(self):
        rep = get_object_or_404(Rep, slug=self.kwargs.get('slug'))
        return Mem.objects.filter(rep=rep, status=Mem.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(RepMemsListView, self).get_context_data(**kwargs)
        rep = get_object_or_404(Rep, slug=self.kwargs.get('slug'))
        context['rep'] = rep
        return context
    

class RepListView(ListView):
    context_object_name = "reps"
    paginate_by = 12
    queryset = Rep.objects.filter(status=Rep.PUBLISHED, deleted=False)
    template_name = "blog/rep/rep_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['rooms'] = Room.objects.filter(approved=True)
        return context


class RepDetailView(DetailView):
    model = Rep
    template_name = 'blog/rep/rep_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_rep {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_reps'] = \
            Rep.objects.filter(room=self.object.room, status=Rep.PUBLISHED).order_by('?')[:3]
        kwargs['rep'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class RepSearchListView(ListView):
    model = Rep
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/rep/rep_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the rep content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Rep.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Rep.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Rep.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(RepSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Room.objects.filter(approved=True)
        return context


class TagRepsListView(ListView):
    """
        List reps related to a tag.
    """
    model = Rep
    paginate_by = 12
    context_object_name = 'tag_reps_list'
    template_name = 'blog/rep/tag_reps_list.html'

    def get_queryset(self):
        """
            Filter Reps by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_reps_list = Rep.objects.filter(tags__name__in=[tag_name],
                                                       status=Rep.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_reps_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_reps_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_reps_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['rooms'] = Room.objects.filter(approved=True)
        return context
