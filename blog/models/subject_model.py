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
from blog.models.course_model import Course


class Subject(models.Model):

    # Subject status constants
    DRAFTED = "DRAFTED"
    PUBLISHED = "PUBLISHED"

    # CHOICES
    STATUS_CHOICES = (
        (DRAFTED, 'Draft'),
        (PUBLISHED, 'Publish'),
    )

    # BLOG MODEL FIELDS
    course = models.ForeignKey(Course, on_delete=models.CASCADE,
                                 related_name='subjects')
    title = models.CharField(max_length=250, null=False, blank=False)
    slug = models.SlugField()
    author = models.ForeignKey(User, on_delete=models.CASCADE,
                               related_name='subjects')
    image = models.ImageField(default='subject-default.jpg',
                              upload_to='subject_pics')
    image_credit = models.CharField(max_length=250, null=True, blank=True)
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
        super(Subject, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('blog:subject_rooms', kwargs={'slug': self.slug})


