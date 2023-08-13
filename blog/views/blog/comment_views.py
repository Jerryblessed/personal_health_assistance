# Core Django imports.
from django.shortcuts import get_object_or_404, redirect
from django.contrib import messages
from django.views.generic import (
    CreateView,
    ListView,
)

# Blog application imports.
from blog.models.chair_model import Chair
from blog.models.comment_models import Comment
from blog.forms.blog.comment_forms import CommentForm


class CommentCreateView(CreateView):
    form_class = CommentForm

    def form_valid(self, form):
        comment = form.save(commit=False)
        comment.chair = get_object_or_404(Chair,
                                            slug=self.kwargs.get('slug'))
        comment.save()
        messages.success(self.request, "Comment Added successfully")
        return redirect('blog:chair_comments', comment.chair.slug)


class ChairCommentList(ListView):
    context_object_name = "comments"
    paginate_by = 10
    template_name = "blog/comment/chair_comments.html"

    def get_queryset(self):
        chair = get_object_or_404(Chair, slug=self.kwargs.get('slug'))
        queryset = Comment.objects.filter(chair=chair)
        return queryset

    def get_context_data(self, **kwargs):
        context = super(ChairCommentList, self).get_context_data(**kwargs)
        context['chair'] = get_object_or_404(Chair,
                                               slug=self.kwargs.get('slug'))
        context['comment_form'] = CommentForm
        return context

