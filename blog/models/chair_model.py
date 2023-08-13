# Core Django imports.
from django.contrib.auth.models import User
from django.db import models
from django.urls import reverse
from django.utils import timezone
from django.utils.text import slugify

# Third party app imports
from taggit.managers import TaggableManager
from ckeditor_uploader.fields import RichTextUploadingField

# Blog application imports.
from blog.utils.blog_utils import count_words, read_time
from blog.models.table_model import Table
import os

class Chair(models.Model):

    # Article status constants
    DRAFTED = "DRAFTED"
    PUBLISHED = "PUBLISHED"

    # CHOICES
    STATUS_CHOICES = (
        (DRAFTED, 'Draft'),
        (PUBLISHED, 'Publish'),
    )

    # BLOG MODEL FIELDS
    table = models.ForeignKey(Table, on_delete=models.CASCADE,
                                 related_name='Chair')
    title = models.CharField(max_length=250, null=False, blank=False)
    file = models.FileField(null=True,blank=True,upload_to='Files')
    enrolled = models.ManyToManyField(User)
    slug = models.SlugField()
    #FoodCat = models.CharField(max_length=30)
    author = models.ForeignKey(User, on_delete=models.CASCADE,
                               related_name='chairs')
    image = models.ImageField(default='chair-default.jpg',upload_to='chair_pics')
    image_credit = models.CharField(max_length=250, null=True)
    body = RichTextUploadingField(blank=True)
    tags = TaggableManager(blank=True)
    date_published = models.DateTimeField(null=True, blank=True,
                                          default=timezone.now)
    date_created = models.DateTimeField(auto_now_add=True)
    date_updated = models.DateTimeField(auto_now=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES,
                              default='DRAFT')
    views = models.PositiveIntegerField(default=0)
    count_words = models.CharField(max_length=50, default=0)
    read_time = models.CharField(max_length=50, default=0)
    deleted = models.BooleanField(default=False)

    class Meta:
        unique_together = ("title",)
        ordering = ('-date_published',)

    def __str__(self):
        return self.title

    def save(self, *args, **kwargs):
        self.slug = slugify(self.title, allow_unicode=True)
        self.count_words = count_words(self.body)
        self.read_time = read_time(self.body)
        super(Chair, self).save(*args, **kwargs)
    
    def extension(self):
       name, extension = os.path.splitext(self.file.name)
       return extension

    def get_absolute_url(self):
        return reverse('blog:chair_detail', kwargs={'username': self.author.username.lower(), 'slug': self.slug})

# class Cart(models.Model):
# 	CartId    = models.AutoField(primary_key=True)
# 	CustEmail = models.CharField(max_length=50)
# 	class Meta:
# 		db_table = "FP_Cart"