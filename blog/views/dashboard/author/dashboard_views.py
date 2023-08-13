# Django imports.
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render, redirect
from django.utils import timezone
from django.views.generic import View

# Blog app imports.
from blog.forms.blog.chair_forms import ChairUpdateForm, ChairCreateForm
from blog.models.chair_model import Chair

# id
from django.shortcuts import render, redirect
from django.db import connection, transaction
# food model
#from foodapp.models import Food,Cust,Admin,Cart,Order
from django.contrib.staticfiles.views import serve

cursor = connection.cursor()

class DashboardHomeView(LoginRequiredMixin, View):
    """
    Display homepage of the dashboard.
    """
    context = {}
    template_name = 'dashboard/author/dashboard_home.html'

    def get(self, request, *args, **kwargs):
        """
        Returns the author details
        """
        user = request.user
        files = Chair.objects.filter(enrolled=user)
        
        context = {
		'files': files
	    }
        
        chairs_list = Chair.objects.filter(author=request.user)
        total_chairs_written = len(chairs_list)
        total_chairs_published = len(chairs_list.filter(status=Chair.PUBLISHED, deleted=False))
        total_chairs_views = sum(chair.views for chair in chairs_list)
        total_chairs_comments = sum(chair.comments.count() for chair in chairs_list)
        recent_published_chairs_list = chairs_list.filter(status=Chair.PUBLISHED, deleted=False).order_by("-date_published")[:5]

        self.context['total_chairs_written'] = total_chairs_written
        self.context['total_chairs_published'] = total_chairs_published
        self.context['total_chairs_views'] = total_chairs_views
        self.context['total_chairs_comments'] = total_chairs_comments
        self.context['recent_published_chairs_list'] = recent_published_chairs_list

        return render(request, self.template_name, self.context, context)
    
# def showcart(request):
# 	cart=Cart.objects.raw('Select CartId,FoodName,FoodPrice,FoodQuant,FoodImage from FP_Food as f inner join FP_Cart as c on f.FoodId=c.FoodId where c.CustEmail="%s"'%request.user)
# 	transaction.commit()
# 	return render(request,"cartlist.html",{'cartlist':cart})
	
 
# def getfile(request):
#    return serve(request, 'File')


	
# def addcart(request,FoodId):
# 	sql = ' Insert into FP_Cart(CustEmail,FoodId,FoodQuant) values("%s","%d","%d")'%(request.session['CustId'],FoodId,1)
# 	i=cursor.execute(sql)
# 	transaction.commit()
# 	return redirect('/allfood')
	
# def delcart(request,CartId):
# 	cart = Cart.objects.get(CartId=CartId)
# 	cart.delete()
# 	return redirect("/allcart")
	


class ChairWriteView(LoginRequiredMixin, View):

    SAVE_AS_DRAFT = "SAVE_AS_DRAFT"
    PUBLISH = "PUBLISH"

    template_name = 'dashboard/author/chair_create_form.html'
    context_object = {}

    def get(self, request, *args, **kwargs):

        chair_create_form = ChairCreateForm()
        self.context_object["chair_create_form"] = chair_create_form

        return render(request, self.template_name, self.context_object)

    def post(self, request, *args, **kwargs):

        chair_create_form = ChairCreateForm(request.POST, request.FILES)

        action = request.POST.get("action")
        chair_status = request.POST["status"]

        if action == self.SAVE_AS_DRAFT:

            if chair_status == Chair.PUBLISHED:
                self.context_object["chair_create_form"] = chair_create_form
                messages.error(request,
                               "You saved the chair as draft but selected "
                               "the status as 'PUBLISHED'. You can't save an "
                               "chair whose status is 'PUBLISHED' as draft. "
                               "Please change the status to 'DRAFT' before you "
                               "save the chair as draft.")
                return render(request, self.template_name, self.context_object)

            if chair_create_form.is_valid():

                new_chair = chair_create_form.save(commit=False)
                new_chair.author = request.user
                new_chair.date_published = None
                new_chair.save()
                chair_create_form.save_m2m()

                messages.success(request, f"Chair drafted successfully.")
                return redirect("blog:drafted_chairs")

            self.context_object["chair_create_form"] = chair_create_form
            messages.error(request, "Please fill required fields")
            return render(request, self.template_name, self.context_object)

        if action == self.PUBLISH:

            if chair_status == Chair.DRAFTED:
                self.context_object["chair_create_form"] = chair_create_form

                messages.error(request,
                               "You clicked on 'PUBLISH' to publish the chair"
                               " but selected the status as 'DRAFT'. "
                               "You can't Publish an chair whose status is "
                               "'DRAFT'. Please change the status to "
                               "'PUBLISHED' before you can Publish the "
                               "chair.")
                return render(request, self.template_name, self.context_object)

            if chair_create_form.is_valid():
                new_chair = chair_create_form.save(commit=False)
                new_chair.author = request.user
                new_chair.save()
                chair_create_form.save_m2m()

                messages.success(self.request, f"Chair published successfully.")
                return redirect(to="blog:dashboard_chair_detail", slug=new_chair.slug)

            self.context_object["chair_create_form"] = chair_create_form
            messages.error(request, "Please fill required fields")
            return render(request, self.template_name, self.context_object)


class ChairUpdateView(LoginRequiredMixin, View):

    SAVE_AS_DRAFT = "SAVE_AS_DRAFT"
    PUBLISH = "PUBLISH"

    template_name = 'dashboard/author/chair_update_form.html'
    context_object = {}

    def get(self, request, *args, **kwargs):

        old_chair = get_object_or_404(Chair, slug=self.kwargs.get("slug"))
        chair_update_form = ChairUpdateForm(instance=old_chair, initial={'tags': old_chair.tags.names})

        self.context_object["chair_update_form"] = chair_update_form
        self.context_object["chair"] = old_chair
        return render(request, self.template_name, self.context_object)

    def post(self, request, *args, **kwargs):

        old_chair = get_object_or_404(Chair, slug=self.kwargs.get("slug"))
        chair_update_form = ChairCreateForm(request.POST, request.FILES, instance=old_chair)

        action = request.POST.get("action")
        chair_status = request.POST["status"]

        if action == self.SAVE_AS_DRAFT:

            if chair_status == Chair.PUBLISHED:
                self.context_object["chair_update_form"] = chair_update_form
                messages.error(request,
                               "You saved the chair as draft but selected "
                               "the status as 'PUBLISHED'. You can't save an "
                               "chair whose status is 'PUBLISHED' as draft. "
                               "Please change the status to 'DRAFT' before you "
                               "save the chair as draft.")
                return render(request, self.template_name, self.context_object)

            if not request.user == old_chair.author.username:
                messages.error(request=self.request, message="You do not have permission to update this chair.")
                return redirect(to="blog:written_chairs")

            if chair_update_form.is_valid():
                updated_chair = chair_update_form.save(commit=False)
                updated_chair.author = request.user
                updated_chair.date_published = None
                updated_chair.date_updated = timezone.now()
                updated_chair.save()
                chair_update_form.save_m2m()

                messages.success(request, f"Chair drafted successfully.")
                return redirect("blog:drafted_chairs")

            self.context_object["chair_update_form"] = chair_update_form
            messages.error(request, "Please fill required fields")
            return render(request, self.template_name, self.context_object)

        if action == self.PUBLISH:

            if chair_status == Chair.DRAFTED:
                self.context_object["chair_update_form"] = chair_update_form

                messages.error(request,
                               "You clicked on 'PUBLISH' to publish the chair"
                               " but selected the status as 'DRAFT'. "
                               "You can't Publish an chair whose status is "
                               "'DRAFT'. Please change the status to "
                               "'PUBLISHED' before you can Publish the "
                               "chair.")
                return render(request, self.template_name, self.context_object)

            if chair_update_form.is_valid():

                updated_chair = chair_update_form.save(commit=False)
                updated_chair.author = request.user
                updated_chair.date_published = timezone.now()
                updated_chair.date_updated = timezone.now()
                updated_chair.save()
                chair_update_form.save_m2m()

                messages.success(self.request, f"Chair updated successfully.")
                return redirect(to="blog:dashboard_chair_detail", slug=updated_chair.slug)

            self.context_object["chair_update_form"] = chair_update_form
            messages.error(request, "Please fill required fields")
            return render(request, self.template_name, self.context_object)


class ChairDeleteView(LoginRequiredMixin, View):
    """
      Deletes chair
    """

    def get(self, *args, **kwargs):
        """
           Checks if user who has requested to delete the chair is the
           owner of the chair.
           If the user is the owner, it sets the deleted field of the chair to true and
           return a successful message.
           If the user is not the owner, it tells user he/she can't delete it
        """
        chair = get_object_or_404(Chair, slug=self.kwargs.get("slug"))

        if not self.request.user.username == chair.author.username:
            messages.error(request=self.request, message="You do not have permission to delete this chair.")
            return HttpResponseRedirect(self.request.META.get('HTTP_REFERER', '/'))

        chair.deleted = True
        chair.save()

        messages.success(request=self.request, message="Chair Deleted Successfully")
        return redirect(to='blog:deleted_chairs')


class DashboardChairDetailView(LoginRequiredMixin, View):
    """
       Displays chair details.
    """

    def get(self, request, *args, **kwargs):
        """
           Returns chair details.
        """
        template_name = 'dashboard/author/dashboard_chair_detail.html'
        context_object = {}

        chair = get_object_or_404(Chair, slug=self.kwargs.get("slug"))

        context_object['chair_title'] = chair.title
        context_object['chair'] = chair

        return render(request, template_name, context_object)


class ChairPublishView(LoginRequiredMixin, View):
    """
       View to publish a drafted chair
    """

    def get(self, request, *args, **kwargs):
        """
            Gets chair slug from user and gets the chair from the
            database.
            It then sets the status to publish and date published to now and
            then save the chair and redirects the author to his/her published
            chairs.
        """
        chair = get_object_or_404(Chair, slug=self.kwargs.get('slug'))
        chair.status = Chair.PUBLISHED
        chair.date_published = timezone.now()
        chair.date_updated = timezone.now()
        chair.save()

        messages.success(request, f"Chair Published successfully.")
        return redirect('blog:dashboard_chair_detail', slug=chair.slug)


class AuthorWrittenChairsView(LoginRequiredMixin, View):
    """
       Displays all chairs written by an author.
    """

    def get(self, request):
        """
           Returns all chairs written by an author.
        """
        template_name = 'dashboard/author/author_written_chair_list.html'
        context_object = {}

        written_chairs = Chair.objects.filter(author=request.user.id, deleted=False).order_by('-date_created')
        total_chairs_written = len(written_chairs)

        page = request.GET.get('page', 1)

        paginator = Paginator(written_chairs, 5)
        try:
            written_chairs_list = paginator.page(page)
        except PageNotAnInteger:
            written_chairs_list = paginator.page(1)
        except EmptyPage:
            written_chairs_list = paginator.page(paginator.num_pages)

        context_object['written_chairs_list'] = written_chairs_list
        context_object['total_chairs_written'] = total_chairs_written

        return render(request, template_name, context_object)


class AuthorPublishedChairsView(LoginRequiredMixin, View):
    """
       Displays published chairs by an author.
    """

    def get(self, request):
        """
           Returns published chairs by an author.
        """
        template_name = 'dashboard/author/author_published_chair_list.html'
        context_object = {}

        published_chairs = Chair.objects.filter(author=request.user.id,
                                                    status=Chair.PUBLISHED, deleted=False).order_by('-date_published')
        total_chairs_published = len(published_chairs)

        page = request.GET.get('page', 1)

        paginator = Paginator(published_chairs, 5)
        try:
            published_chairs_list = paginator.page(page)
        except PageNotAnInteger:
            published_chairs_list = paginator.page(1)
        except EmptyPage:
            published_chairs_list = paginator.page(paginator.num_pages)

        context_object['published_chairs_list'] = published_chairs_list
        context_object['total_chairs_published'] = total_chairs_published

        return render(request, template_name, context_object)


class AuthorDraftedChairsView(LoginRequiredMixin, View):
    """
       Displays drafted chairs by an author.
    """

    def get(self, request):
        """
           Returns drafted chairs by an author.
        """
        template_name = 'dashboard/author/author_drafted_chair_list.html'
        context_object = {}

        drafted_chairs = Chair.objects.filter(author=request.user.id,
                                                  status=Chair.DRAFTED, deleted=False).order_by('-date_created')
        total_chairs_drafted = len(drafted_chairs)

        page = request.GET.get('page', 1)

        paginator = Paginator(drafted_chairs, 5)
        try:
            drafted_chairs_list = paginator.page(page)
        except PageNotAnInteger:
            drafted_chairs_list = paginator.page(1)
        except EmptyPage:
            drafted_chairs_list = paginator.page(paginator.num_pages)

        context_object['drafted_chairs_list'] = drafted_chairs_list
        context_object['total_chairs_drafted'] = total_chairs_drafted

        return render(request, template_name, context_object)


class AuthorDeletedChairsView(LoginRequiredMixin, View):
    """
       Displays deleted chairs by an author.
    """

    def get(self, request):
        """
           Returns deleted chairs by an author.
        """
        template_name = 'dashboard/author/author_deleted_chair_list.html'
        context_object = {}

        deleted_chairs = Chair.objects.filter(author=request.user.id,
                                                  deleted=True).order_by('-date_published')
        total_chairs_deleted = len(deleted_chairs)

        page = request.GET.get('page', 1)

        paginator = Paginator(deleted_chairs, 5)
        try:
            deleted_chairs_list = paginator.page(page)
        except PageNotAnInteger:
            deleted_chairs_list = paginator.page(1)
        except EmptyPage:
            deleted_chairs_list = paginator.page(paginator.num_pages)

        context_object['deleted_chairs_list'] = deleted_chairs_list
        context_object['total_chairs_deleted'] = total_chairs_deleted

        return render(request, template_name, context_object)


