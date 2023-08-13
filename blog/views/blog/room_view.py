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
from blog.models.room_model import Room
from blog.models.subject_model import Subject
from blog.forms.blog.comment_forms import CommentForm
from blog.models.rep_model import Room, Rep

class RoomRepsListView(ListView):
    model = Rep
    paginate_by = 12
    context_object_name = 'reps'
    template_name = 'blog/room/room_reps.html'

    def get_queryset(self):
        room = get_object_or_404(Room, slug=self.kwargs.get('slug'))
        return Rep.objects.filter(room=room, status=Rep.PUBLISHED, deleted=False)

    def get_context_data(self, **kwargs):
        context = super(RoomRepsListView, self).get_context_data(**kwargs)
        room = get_object_or_404(Room, slug=self.kwargs.get('slug'))
        context['room'] = room
        return context
    

class RoomListView(ListView):
    context_object_name = "rooms"
    paginate_by = 12
    queryset = Room.objects.filter(status=Room.PUBLISHED, deleted=False)
    template_name = "blog/room/room_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['subjects'] = Subject.objects.filter(approved=True)
        return context


class RoomDetailView(DetailView):
    model = Room
    template_name = 'blog/room/room_detail.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_room {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_rooms'] = \
            Room.objects.filter(subject=self.object.subject, status=Room.PUBLISHED).order_by('?')[:3]
        kwargs['room'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class RoomSearchListView(ListView):
    model = Room
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/room/room_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the room content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Room.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Room.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Room.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(RoomSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Subject.objects.filter(approved=True)
        return context


class TagRoomsListView(ListView):
    """
        List rooms related to a tag.
    """
    model = Room
    paginate_by = 12
    context_object_name = 'tag_rooms_list'
    template_name = 'blog/room/tag_rooms_list.html'

    def get_queryset(self):
        """
            Filter Rooms by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_rooms_list = Room.objects.filter(tags__name__in=[tag_name],
                                                       status=Room.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_rooms_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_rooms_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_rooms_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['subjects'] = Subject.objects.filter(approved=True)
        return context
