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

# id
from django.shortcuts import render, redirect
from django.db import connection, transaction
# food model
#from foodapp.models import Food,Cust,Admin,Cart,Order

# Blog application imports.
from blog.models.table_model import Table
from blog.models.chair_model import Chair
from blog.forms.blog.comment_forms import CommentForm
from django.contrib.staticfiles.views import serve

cursor = connection.cursor()


class ChairListView(ListView):
    context_object_name = "chairs"
    paginate_by = 12
    queryset = Chair.objects.filter(status=Chair.PUBLISHED, deleted=False)
    template_name = "blog/chair/chair_list.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['chairs'] = Chair.objects.filter(approved=True)
        return context


class ChairDetailView(DetailView):
    model = Chair
    template_name = 'blog/chair/chair_details.html'

    def get_context_data(self, **kwargs):
        session_key = f"viewed_chair {self.object.slug}"
        if not self.request.session.get(session_key, False):
            self.object.views += 1
            self.object.save()
            self.request.session[session_key] = True

        kwargs['related_chairs'] = \
            Chair.objects.filter(table=self.object.table, status=Chair.PUBLISHED).order_by('?')[:3]
        kwargs['chair'] = self.object
        kwargs['comment_form'] = CommentForm()
        return super().get_context_data(**kwargs)


class ChairSearchListView(ListView):
    model = Chair
    paginate_by = 12
    context_object_name = 'search_results'
    template_name = "blog/chair/chair_search_list.html"

    def get_queryset(self):
        """
        Search for a user input in the search bar.

        It pass in the query value to the search view using the 'q' parameter.
        Then in the view, It searches the 'title', 'slug', 'body' and fields.

        To make the search a little smarter, say someone searches for
        'container docker ansible' and It want to search the records where all
        3 words appear in the chair content in any order, It split the query
        into separate words and chain them.
        """

        query = self.request.GET.get('q')

        if query:
            query_list = query.split()
            search_results = Chair.objects.filter(
                reduce(operator.and_,
                       (Q(title__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(slug__icontains=q) for q in query_list)) |
                reduce(operator.and_,
                       (Q(body__icontains=q) for q in query_list))
            )

            if not search_results:
                messages.info(self.request, f"No results for '{query}'")
                return search_results.filter(status=Chair.PUBLISHED, deleted=False)
            else:
                messages.success(self.request, f"Results for '{query}'")
                return search_results.filter(status=Chair.PUBLISHED, deleted=False)
        else:
            messages.error(self.request, f"Sorry you did not enter any keyword")
            return []

    def get_context_data(self, **kwargs):
        """
            Add categories to context data
        """
        context = super(ChairSearchListView, self).get_context_data(**kwargs)
        context['categories'] = Table.objects.filter(approved=True)
        return context


class TagChairsListView(ListView):
    """
        List chairs related to a tag.
    """
    model = Chair
    paginate_by = 12
    context_object_name = 'tag_chairs_list'
    template_name = 'blog/chair/tag_chairs_list.html'

    def get_queryset(self):
        """
            Filter Chairs by tag_name
        """

        tag_name = self.kwargs.get('tag_name', '')

        if tag_name:
            tag_chairs_list = Chair.objects.filter(tags__name__in=[tag_name],
                                                       status=Chair.PUBLISHED,
                                                       deleted=False
                                                       )

            if not tag_chairs_list:
                messages.info(self.request, f"No Results for '{tag_name}' tag")
                return tag_chairs_list
            else:
                messages.success(self.request, f"Results for '{tag_name}' tag")
                return tag_chairs_list
        else:
            messages.error(self.request, "Invalid tag")
            return []

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['Tables'] = Table.objects.filter(approved=True)
        return context
    
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
	
# def showcart(request):
# 	cart=Cart.objects.raw('Select CartId,FoodName,FoodPrice,FoodQuant,FoodImage from FP_Food as f inner join FP_Cart as c on f.FoodId=c.FoodId where c.CustEmail="%s"'%request.session['CustId'])
# 	transaction.commit()
# 	return render(request,"cartlist.html",{'cartlist':cart})
	