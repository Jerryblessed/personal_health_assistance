# Core Django imports.
from django.urls import path

# Blog application imports.
from blog.views.blog.chair_view import (
    TagChairsListView,
    ChairListView,
    ChairDetailView,
    ChairSearchListView
    
)

from blog.views.blog.table_view import(
    TableChairsListView,
    TagTablesListView,
    TableListView,
    TableDetailView,
    TableSearchListView
    
)

from blog.views.blog.mem_view import(
    
    MemTablesListView,
    TagMemsListView,
    MemListView,
    MemDetailView,
    MemSearchListView
)

from blog.views.blog.rep_view import(
    TagRepsListView,
    RepMemsListView,
    RepListView,
    RepDetailView,
    RepSearchListView
)

from blog.views.blog.room_view import(
    TagRoomsListView,
    RoomRepsListView,
    RoomListView,
    RoomDetailView,
    RoomSearchListView
)

from blog.views.blog.subject_view import (
    SubjectRoomsListView,
    SubjectListView,
    SubjectDetailView,
    SubjectSearchListView,
    TagSubjectsListView,
)

from blog.views.blog.course_view import (
    CourseSubjectListView,
    CourseListView,
    CourseDetailView,
    CourseSearchListView,
    TagCoursesListView,
)

from blog.views.blog.article_views import (
    ArticleCoursesListView,
    ArticleListView,
    ArticleDetailView,
    ArticleSearchListView,
    TagArticlesListView,
)

from blog.views.blog.category_views import (
    CategoryArticlesListView,
    CategoriesListView,
    CategoryCreateView,
    CategoryUpdateCreateView,
)

from blog.views.blog.author_views import (
    AuthorChairListView,
    AuthorsListView,
)

from blog.views.blog.comment_views import (
    CommentCreateView,
    ChairCommentList
)

from blog.views.dashboard.author.dashboard_views import (
    DashboardHomeView,
    ChairWriteView,
    ChairUpdateView,
    ChairDeleteView,
    DashboardChairDetailView,
    ChairPublishView,
    AuthorWrittenChairsView,
    AuthorPublishedChairsView,
    AuthorDraftedChairsView,
    AuthorDeletedChairsView,
)

from blog.views.dashboard.author.author_profile_views import (
    AuthorProfileUpdateView,
    AuthorProfileView,
)

from blog.views.account.register_view import \
    (
      ActivateView,
      AccountActivationSentView,
      UserRegisterView,
    )
from blog.views.account.logout_view import UserLogoutView
from blog.views.account.login_view import UserLoginView


# Specifies the app name for name spacing.
app_name = "blog"

# article/urls.py
urlpatterns = [
        # CHAIRS URLS #

    # /home/
    path(
         route='chairs/list',
        view=ChairListView.as_view(),
        name='chairs_list'
    ),
    
    # /chairs/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=ChairDetailView.as_view(),
        name='chair_detail'

    ),

    # /search/?q=query/
    path(
        route='chairs/search/',
        view=ChairSearchListView.as_view(),
        name='chairs_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/chairss',
        view=TagChairsListView.as_view(),
        name="tag_chairs"
    ),

    
    # TABLES URLS #
     path(
        route='table/<str:slug>/chairs',
        view=TableChairsListView.as_view(),
        name='table_chairs'
    ),

    # /home/
    path(
         route='tables/list',
        view=TableListView.as_view(),
        name='tables_list'
    ),
    
    # /tabless/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=TableDetailView.as_view(),
        name='tables_detail'

    ),

    # /search/?q=query/
    path(
        route='tables/search/',
        view=TableSearchListView.as_view(),
        name='tables_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/tablesss',
        view=TagTablesListView.as_view(),
        name="tag_tables"
    ),

    # MEM URLS #

    # /home/
    path(
         route='mems/list',
        view=MemListView.as_view(),
        name='mems_list'
    ),
      path(
         route='course/categories/<str:slug>',
         view=MemTablesListView.as_view(),
         name='mem_tables'
     ),

    # /mem/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=MemDetailView.as_view(),
        name='mem_detail'

    ),

    # /search/?q=query/
    path(
        route='mem/search/',
        view=MemSearchListView.as_view(),
        name='mem_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/mems',
        view=TagMemsListView.as_view(),
        name="tag_mems"
    ),

    # REP URLS #

    # /home/
    path(
         route='reps/list',
        view=RepListView.as_view(),
        name='reps_list'
    ),
     path(
        route='rep/<str:slug>/mems',
        view=RepMemsListView.as_view(),
        name='rep_mems'
    ),

    # /rep/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=RepDetailView.as_view(),
        name='rep_detail'

    ),

    # /search/?q=query/
    path(
        route='rep/search/',
        view=RepSearchListView.as_view(),
        name='rep_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/reps',
        view=TagRepsListView.as_view(),
        name="tag_reps"
    ),

    # ROOM URLS #

    # /home/
    path(
         route='rooms/list',
        view=RoomListView.as_view(),
        name='rooms_list'
    ),
     path(
        route='room/<str:slug>/reps',
        view=RoomRepsListView.as_view(),
        name='room_reps'
    ),

    # /room/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=RoomDetailView.as_view(),
        name='room_detail'

    ),

    # /search/?q=query/
    path(
        route='room/search/',
        view=RoomSearchListView.as_view(),
        name='room_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/rooms',
        view=TagRoomsListView.as_view(),
        name="tag_rooms"
    ),

    
    # SUBJECT URLS #

    # /home/
    path(
         route='subjects/list',
        view=SubjectListView.as_view(),
        name='subjects_list'
    ),
     path(
        route='subject/<str:slug>/rooms',
        view=SubjectRoomsListView.as_view(),
        name='subject_rooms'
    ),

    # /subject/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=SubjectDetailView.as_view(),
        name='subject_detail'

    ),

    # /search/?q=query/
    path(
        route='subject/search/',
        view=SubjectSearchListView.as_view(),
        name='subject_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/subjects',
        view=TagSubjectsListView.as_view(),
        name="tag_subjects"
    ),


    

    # Course URLS #

    # /home/
    path(
        route='courses/list',
        view=CourseListView.as_view(),
        name='courses_list'
    ),
   
    path(
        route='course/<str:slug>/subjects',
        view=CourseSubjectListView.as_view(),
        name='course_subjects'
    ),

    # /course/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=CourseDetailView.as_view(),
        name='course_detail'

    ),

    # /search/?q=query/
    path(
        route='course/search/',
        view=CourseSearchListView.as_view(),
        name='course_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/courses',
        view=TagCoursesListView.as_view(),
        name="tag_courses"
    ),


    # ARTICLE URLS #

    # /home/
    path(
        route='',
        view=ArticleListView.as_view(),
        name='home'
    ),
     path(
        route='article/<str:slug>/courses/',
        view=ArticleCoursesListView.as_view(),
        name='article_courses'
    ),

    # /article/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=ArticleDetailView.as_view(),
        name='article_detail'

    ),

    # /search/?q=query/
    path(
        route='article/search/',
        view=ArticleSearchListView.as_view(),
        name='article_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/articles',
        view=TagArticlesListView.as_view(),
        name="tag_articles"
    ),


    # AUTHORS URLS #

    # /authors-list/
    path(
        route='authors/list/',
        view=AuthorsListView.as_view(),
        name='authors_list'
    ),

    # /author/<str:username>/
    path(
        route='author/<str:username>/chairs',
        view=AuthorChairListView.as_view(),
        name='author_chairs'
     ),


    # CATEGORY URLS #

    # category-articles/<str:slug>/
    path(
        route='category/<str:slug>/articles/',
        view=CategoryArticlesListView.as_view(),
        name='category_articles'
    ),

    # /categories-list/
    path(
        route='categories/list/',
        view=CategoriesListView.as_view(),
        name='categories_list'
    ),

    # /category/new/
    path(
        route='category/create/',
        view=CategoryCreateView.as_view(),
        name="category_create"
    ),

    # /category/<str:slug>/update/
    path(
        route='category/<str:slug>/update/',
        view=CategoryUpdateCreateView.as_view(),
        name="category_update"
    ),




    # COMMENT URLS #

    # /comment/new/
    path(
        route='comment/new/<str:slug>/',
        view=CommentCreateView.as_view(),
        name="comment_create"
    ),

    # /<str:slug>/comments/
    path(
        route='<str:slug>/comments/',
        view=ChairCommentList.as_view(),
        name="chair_comments"
    ),


    # ACCOUNT URLS #

    # account/login/
    path(
        route='account/login/',
        view=UserLoginView.as_view(),
        name='login'
    ),

    # account/login/
    path(
        route='account/register/',
        view=UserRegisterView.as_view(),
        name='register'
    ),

    # account/logout/
    path(
        route='account/logout/',
        view=UserLogoutView.as_view(),
        name='logout'
    ),

    path(route='account_activation_sent/',
         view=AccountActivationSentView.as_view(),
         name='account_activation_sent'
         ),

    path(route='activate/<uidb64>/<token>/',
         view=ActivateView.as_view(),
         name='activate'
         ),



    # DASHBOARD URLS #

    # /author/dashboard/
    path(
        route="author/dashboard/home/",
        view=DashboardHomeView.as_view(),
        name="dashboard_home"
    ),

    # author/profile/details
    path(
        route='author/profile/details/',
        view=AuthorProfileView.as_view(),
        name='author_profile_details'
    ),

    # author/profile/update/
    path(
        route='author/profile/update/',
        view=AuthorProfileUpdateView.as_view(),
        name='author_profile_update'
    ),

    # me/article/write
    path(
        route='me/article/write/',
        view=ChairWriteView.as_view(),
        name="article_write"
    ),

    # me/article/<str:slug>/update/
    path(
        route='me/article/<str:slug>/update/',
        view=ChairUpdateView.as_view(),
        name="article_update"
    ),

    # /article/<str:slug>/delete/
    path(
        route='me/article/<str:slug>/delete/',
        view=ChairDeleteView.as_view(),
        name="article_delete"
    ),

    # /me/<str:slug>/publish/
    path(
        route="article/<str:slug>/publish/",
        view=ChairPublishView.as_view(),
        name="publish_article"
    ),

    # /me/articles/written/
    path(
        route="me/articles/written/",
        view=AuthorWrittenChairsView.as_view(),
        name="written_articles"
    ),

    # /me/articles/published/
    path(
        route="me/articles/published/",
        view=AuthorPublishedChairsView.as_view(),
        name="published_articles"
    ),

    # /me/articles/drafted/
    path(
        route="me/articles/drafts/",
        view=AuthorDraftedChairsView.as_view(),
        name="drafted_articles"
    ),

    # /me/articles/deleted/
    path(
        route="me/articles/deleted/",
        view=AuthorDeletedChairsView.as_view(),
        name="deleted_articles"
    ),

    # /me/<str:slug>/
    path(
        route="me/<str:slug>/",
        view=DashboardChairDetailView.as_view(),
        name='dashboard_article_detail'

    ),

]
