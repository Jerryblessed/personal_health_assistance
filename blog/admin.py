# Core Django imports.
from django.contrib import admin

# Blog application imports.
from .models.article_models import Article
from .models.category_models import Category
from .models.comment_models import Comment
from .models.comment_models import CommentCourse
from .models.author_models import Profile
from .models.course_model import Course
from .models.subject_model import Subject
from .models.room_model import Room
from .models.rep_model import Rep
from .models.mem_model import Mem
from .models.table_model import Table
from .models.chair_model import Chair

# class ProfileAdmin(admin.ModelAdmin):
#     list_filter = ('user',)
#     search_fields = ('user',)
#     ordering = ['user', ]


# # Registers the author profile model at the admin backend.
# admin.site.register(Profile, ProfileAdmin)


class CategoryAdmin(admin.ModelAdmin):

    list_display = ('name', 'slug', 'image', 'approved')
    list_filter = ('name', 'approved',)
    search_fields = ('name',)
    prepopulated_fields = {'slug': ('name',)}
    ordering = ['name', ]


# Registers the category model at the admin backend.
admin.site.register(Category, CategoryAdmin)


class ArticleAdmin(admin.ModelAdmin):

    list_display = ('category', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the article model at the admin backend.
admin.site.register(Article, ArticleAdmin)

class CourseAdmin(admin.ModelAdmin):

    list_display = ('article', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the course model at the admin backend.
admin.site.register(Course, CourseAdmin)

class SubjectAdmin(admin.ModelAdmin):

    list_display = ('course', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the subject model at the admin backend.
admin.site.register(Subject, SubjectAdmin)


class RoomAdmin(admin.ModelAdmin):

    list_display = ('subject', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the room model at the admin backend.
admin.site.register(Room, RoomAdmin)

class RepAdmin(admin.ModelAdmin):

    list_display = ('room', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the rep model at the admin backend.
admin.site.register(Rep, RepAdmin)

class MemAdmin(admin.ModelAdmin):

    list_display = ('rep', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the mem model at the admin backend.
admin.site.register(Mem, MemAdmin)


class TableAdmin(admin.ModelAdmin):

    list_display = ('mem', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the mem model at the admin backend.
admin.site.register(Table, TableAdmin)


class ChairAdmin(admin.ModelAdmin):

    list_display = ('table', 'title', 'slug', 'author', 'image', 'image_credit',
                    'body', 'date_published', 'status')
    list_filter = ('status', 'date_created', 'date_published', 'author',)
    search_fields = ('title', 'body',)
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ('author',)
    date_hierarchy = 'date_published'
    ordering = ['status', '-date_created', ]
    readonly_fields = ('views', 'count_words', 'read_time')


# Registers the mem model at the admin backend.
admin.site.register(Chair, ChairAdmin)















class CommentAdmin(admin.ModelAdmin):

    list_display = ('name', 'email', 'comment', 'chair', 'date_created', )
    list_filter = ('date_created', 'name',)
    search_fields = ('name', 'chair', 'comment')
    date_hierarchy = 'date_created'
    ordering = ['-date_created', ]
    readonly_fields = ('name', 'email', 'comment', 'chair', 'date_created', 'date_updated',)


# Registers the comment model at the admin backend.
admin.site.register(Comment, CommentAdmin)


class CommentAdmin(admin.ModelAdmin):

    list_display = ('name', 'email', 'comment', 'course', 'date_created', )
    list_filter = ('date_created', 'name',)
    search_fields = ('name', 'article', 'comment')
    date_hierarchy = 'date_created'
    ordering = ['-date_created', ]
    readonly_fields = ('name', 'email', 'comment', 'course', 'date_created', 'date_updated',)


# Registers the comment model at the admin backend.
admin.site.register(CommentCourse, CommentAdmin)
