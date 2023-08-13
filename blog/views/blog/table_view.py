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
from blog.models.table_model import Table
from blog.models.mem_model import Mem
from blog.forms.blog.comment_forms import CommentForm

from blog.models.chair_model import Table, Chair

class TableChairsListView(ListView):
    model = Chair
    paginate_by = 12
    context_object_name = 'chairs'
    template_name = 'blog/table/table_chairs.html'

    def get_queryset(self):
        table = get_object_or_404(Table, slug=self.kwargs.get('slug'))
        return Chair.objects.filter(table=table, status=Chair.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(TableChairsListView, self).get_context_data(**kwargs)
        table = get_object_or_404(Table, slug=self.kwargs.get('slug'))
        context['table'] = table
        return context


class TableListView(ListView):
    context_object_name = "tables"
    paginate_by = 12
    queryset = Table.objects.filter(status=Table.PUBLISHED, deleted=False)
    template_name = "blog/table/table_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['tables'] = Table.objects.filter(approved=True)
        return context


class TableDetailView(DetailView):
    model = Table
    template_name = 'blog/table/table_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_table {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_tables'] = \
            Table.objects.filter(mem=self.object.mem, status=Table.PUBLISHED).order_by('?')[:3]
        kwargs['table'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class TableSearchListView(ListView):
    model = Table
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/table/table_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the table content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Table.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Table.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Table.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(TableSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Mem.objects.filter(approved=True)
        return context


class TagTablesListView(ListView):
    """
        List tables related to a tag.
    """
    model = Table
    paginate_by = 12
    context_object_name = 'tag_tables_list'
    template_name = 'blog/table/tag_tables_list.html'

    def get_queryset(self):
        """
            Filter Tables by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_tables_list = Table.objects.filter(tags__name__in=[tag_name],
                                                       status=Table.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_tables_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_tables_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_tables_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['Mems'] = Mem.objects.filter(approved=True)
        return context
