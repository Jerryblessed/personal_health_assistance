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
from blog.models.mem_model import Mem
from blog.models.rep_model import Rep
from blog.forms.blog.comment_forms import CommentForm

from blog.models.table_model import Mem, Table 

class MemTablesListView(ListView):
    model = Table
    paginate_by = 12
    context_object_name = 'tables'
    template_name = 'blog/mem/mem_tables.html'

    def get_queryset(self):
        mem = get_object_or_404(Mem, slug=self.kwargs.get('slug'))
        return Table.objects.filter(mem=mem, status=Table.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(MemTablesListView, self).get_context_data(**kwargs)
        mem = get_object_or_404(Mem, slug=self.kwargs.get('slug'))
        context['mem'] = mem
        return context
    

class MemListView(ListView):
    context_object_name = "mems"
    paginate_by = 12
    queryset = Mem.objects.filter(status=Mem.PUBLISHED, deleted=False)
    template_name = "blog/mem/rep_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['reps'] = Rep.objects.filter(approved=True)
        return context



class MemListView(ListView):
    context_object_name = "mems"
    paginate_by = 12
    queryset = Mem.objects.filter(status=Mem.PUBLISHED, deleted=False)
    template_name = "blog/mem/mem_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['reps'] = Rep.objects.filter(approved=True)
        return context


class MemDetailView(DetailView):
    model = Mem
    template_name = 'blog/mem/mem_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_mem {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_mems'] = \
            Mem.objects.filter(rep=self.object.rep, status=Mem.PUBLISHED).order_by('?')[:3]
        kwargs['mem'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class MemSearchListView(ListView):
    model = Mem
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/mem/mem_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the mem content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Mem.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Mem.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Mem.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(MemSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Rep.objects.filter(approved=True)
        return context


class TagMemsListView(ListView):
    """
        List mems related to a tag.
    """
    model = Mem
    paginate_by = 12
    context_object_name = 'tag_mems_list'
    template_name = 'blog/mem/tag_mems_list.html'

    def get_queryset(self):
        """
            Filter Mems by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_mems_list = Mem.objects.filter(tags__name__in=[tag_name],
                                                       status=Mem.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_mems_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_mems_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_mems_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['Reps'] = Rep.objects.filter(approved=True)
        return context
