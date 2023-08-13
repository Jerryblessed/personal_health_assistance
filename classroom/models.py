from django.db import models
from django.urls import reverse
from django.utils.text import slugify
from django.contrib.auth.models import User
import uuid

from django.utils import timezone


# Third party app imports
from taggit.managers import TaggableManager
from ckeditor_uploader.fields import RichTextUploadingField

# Create your models here.
from module.models import Module
from assignment.models import Submission
from question.models import Question

#3rd apps field
from ckeditor.fields import RichTextField
from blog.utils.blog_utils import count_words, read_time

from blog.models.mem_model import Mem
STATUS_CHOICES = (
	('pending', 'Pending'),
	('graded', 'Graded'),
)


def user_directory_path(instance, filename):

	#TH\his file will be uploaded to MEDIA_ROOT /the user_(id)/the file
	return 'user_{0}/{1}'.format(instance.user.id, filename)


# class Batch_Category(models.Model):
# 	title = models.CharField(max_length=100, verbose_name='Name')
# 	slug = models.SlugField(unique=True)
# 	def get_absolute_url(self):
# 		return reverse('Batch_categories', arg=[self.slug])

# 	def __str__(self):
# 		return self.title
 	


# class Category(models.Model):
# 	title = models.CharField(max_length=100, verbose_name='Title')
# 	icon = models.CharField(max_length=100, verbose_name='Icon', default='article')
# 	batch = models.ForeignKey(Batch_Category, on_delete=models.CASCAD)
# 	slug = models.SlugField(unique=True)

# 	def get_absolute_url(self):
# 		return reverse('categories', arg=[self.slug])

# 	def __str__(self):
# 		return self.title
### from blog app

# class Category(models.Model):

#     name = models.CharField(max_length=100, null=False, blank=False, default="TAG")
#     slug = models.SlugField()
#     image = models.ImageField(default='category-default.jpg',
#                               upload_to='category_images')
#     approved = models.BooleanField(default=True)

#     class Meta:
#         unique_together = ('name',)
#         verbose_name = 'category'
#         verbose_name_plural = 'categories'

#     def __str__(self):
#         return self.name

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.name, allow_unicode=True)
#         super(Category, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:category_articles',
#                        kwargs={'slug': self.slug})


# class Article(models.Model):

#     # Article status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )
    

#     # BLOG MODEL FIELDS
#     category = models.ForeignKey(Category, on_delete=models.CASCADE,
#                                  related_name='articles')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='articles')
#     image = models.ImageField(default='article-default.jpg',
#                               upload_to='article_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Article, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:article_courses', 
                    
#                      kwargs={'slug': self.slug})
#                     #    kwargs={'username': self.author.username.lower(), 'slug': self.slug})




# class Lecture(models.Model):

#     # Course status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     article = models.ForeignKey(Article, on_delete=models.CASCADE,
#                                  related_name='lectures')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='lectures')
#     image = models.ImageField(default='lecture-default.jpg',
#                               upload_to='lecture_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Lecture, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:lecture_subjects', kwargs={'slug': self.slug})



# class Subject(models.Model):

#     # Subject status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     lecture = models.ForeignKey(Lecture, on_delete=models.CASCADE,
#                                  related_name='subjects')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='subjects')
#     image = models.ImageField(default='subject-default.jpg',
#                               upload_to='subject_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Subject, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:subject_rooms', kwargs={'slug': self.slug})


# class Room(models.Model):

#     # Class status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     subject = models.ForeignKey(Subject, on_delete=models.CASCADE,
#                                  related_name='rooms')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='rooms')
#     image = models.ImageField(default='rooms-default.jpg',
#                               upload_to='rooms_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Room, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:room_reps', kwargs={'slug': self.slug})


# class Rep(models.Model):

#     # Rep status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     room = models.ForeignKey(Room, on_delete=models.CASCADE,
#                                  related_name='reps')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='reps')
#     image = models.ImageField(default='rep-default.jpg',
#                               upload_to='rep_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Rep, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:rep_mems', kwargs={'slug': self.slug})



# class Mem(models.Model):

#     # Mem status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     rep = models.ForeignKey(Rep, on_delete=models.CASCADE,
#                                  related_name='mems')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='mems')
#     image = models.ImageField(default='mem-default.jpg',
#                               upload_to='mem_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Mem, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:mem_tables', kwargs={'slug': self.slug})

# class Table(models.Model):

#     # Mem status constants
#     DRAFTED = "DRAFTED"
#     PUBLISHED = "PUBLISHED"

#     # CHOICES
#     STATUS_CHOICES = (
#         (DRAFTED, 'Draft'),
#         (PUBLISHED, 'Publish'),
#     )

#     # BLOG MODEL FIELDS
#     mem = models.ForeignKey(Mem, on_delete=models.CASCADE,
#                                  related_name='tables')
#     title = models.CharField(max_length=250, null=False, blank=False)
#     slug = models.SlugField()
#     author = models.ForeignKey(User, on_delete=models.CASCADE,
#                                related_name='tables')
#     image = models.ImageField(default='tables-default.jpg',
#                               upload_to='tables_pics')
#     image_credit = models.CharField(max_length=250, null=True, blank=True)
#     body = RichTextUploadingField(blank=True)
# #    tags = TaggableManager(blank=True)
#     date_published = models.DateTimeField(null=True, blank=True,
#                                           default=timezone.now)
#     date_created = models.DateTimeField(auto_now_add=True)
#     date_updated = models.DateTimeField(auto_now=True)
#     status = models.CharField(max_length=10, choices=STATUS_CHOICES,
#                               default='DRAFT')
#     views = models.PositiveIntegerField(default=0)
#     count_words = models.CharField(max_length=50, default=0)
#     read_time = models.CharField(max_length=50, default=0)
#     deleted = models.BooleanField(default=False)

#     class Meta:
#         unique_together = ("title",)
#         ordering = ('-date_published',)

#     def __str__(self):
#         return self.title

#     def save(self, *args, **kwargs):
#         self.slug = slugify(self.title, allow_unicode=True)
#         self.count_words = count_words(self.body)
#         self.read_time = read_time(self.body)
#         super(Table, self).save(*args, **kwargs)

#     def get_absolute_url(self):
#         return reverse('blog:table_chairs', kwargs={ 'slug': self.slug})







class Course(models.Model):
	id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
	picture = models.ImageField(upload_to=user_directory_path)
	title = models.CharField(max_length=200)
	description = models.CharField(max_length=300)
	creadit = models.IntegerField(verbose_name='Creadit Hours', default=4)
	mem = models.ForeignKey(Mem, on_delete=models.CASCADE, default='1')
	syllabus = RichTextField()
	user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='course_owner')
	enrolled = models.ManyToManyField(User)
	modules = models.ManyToManyField(Module)
	questions = models.ManyToManyField(Question)


	def __str__(self):
		return self.title

class Grade(models.Model):
	course = models.ForeignKey(Course, on_delete=models.CASCADE)
	submission = models.ForeignKey(Submission, on_delete=models.CASCADE)
	points = models.PositiveIntegerField(default=0)
	graded_by = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True)
	status = models.CharField(choices=STATUS_CHOICES, default='pending', max_length=10, verbose_name='Status')