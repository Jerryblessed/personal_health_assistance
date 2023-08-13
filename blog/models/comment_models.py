# Core Django imports.
from django.db import models
from django.utils import timezone

# Blog application imports.
from blog.models.chair_model import Chair
from blog.models.course_model import Course

class Comment(models.Model):

    name = models.CharField(max_length=250, null=False, blank=False)
    email = models.EmailField()
    comment = models.TextField(null=False, blank=False)
    chair = models.ForeignKey(Chair, on_delete=models.CASCADE,
                                related_name='comments', default=0)
    date_created = models.DateTimeField(default=timezone.now)
    date_updated = models.DateTimeField(auto_now=True)
    approved = models.BooleanField(default=True)

    class Meta:
        ordering = ('-date_created',)

    def __str__(self):
        return f"Comment by {self.name} on {self.chair}"

class CommentCourse(models.Model):

    name = models.CharField(max_length=250, null=False, blank=False)
    email = models.EmailField()
    comment = models.TextField(null=False, blank=False)
    course = models.ForeignKey(Course, on_delete=models.CASCADE,
                                related_name='commentscourse', default=0)
    date_created = models.DateTimeField(default=timezone.now)
    date_updated = models.DateTimeField(auto_now=True)
    approved = models.BooleanField(default=True)

    class Meta:
        ordering = ('-date_created',)

    def __str__(self):
        return f"Comment by {self.name} on {self.course}"

# class CommentSubject(models.Model):

#     name = models.CharField(max_length=250, null=False, blank=False)
#     email = models.EmailField()
#     comment = models.TextField(null=False, blank=False)
#     chair = models.ForeignKey(Chair, on_delete=models.CASCADE,
#                                 related_name='commentssubject')
#     date_created = models.DateTimeField(default=timezone.now)
#     date_updated = models.DateTimeField(auto_now=True)
#     approved = models.BooleanField(default=True)

#     class Meta:
#         ordering = ('-date_created',)

#     def __str__(self):
#         return f"Comment by {self.name} on {self.chair}"
# class CommentRoom(models.Model):

#     name = models.CharField(max_length=250, null=False, blank=False)
#     email = models.EmailField()
#     comment = models.TextField(null=False, blank=False)
#     chair = models.ForeignKey(Chair, on_delete=models.CASCADE,
#                                 related_name='commentsroom')
#     date_created = models.DateTimeField(default=timezone.now)
#     date_updated = models.DateTimeField(auto_now=True)
#     approved = models.BooleanField(default=True)

#     class Meta:
#         ordering = ('-date_created',)

#     def __str__(self):
#         return f"Comment by {self.name} on {self.chair}"

# class CommentRep(models.Model):

#     name = models.CharField(max_length=250, null=False, blank=False)
#     email = models.EmailField()
#     comment = models.TextField(null=False, blank=False)
#     chair = models.ForeignKey(Chair, on_delete=models.CASCADE,
#                                 related_name='commentsrep')
#     date_created = models.DateTimeField(default=timezone.now)
#     date_updated = models.DateTimeField(auto_now=True)
#     approved = models.BooleanField(default=True)

#     class Meta:
#         ordering = ('-date_created',)

#     def __str__(self):
#         return f"Comment by {self.name} on {self.chair}"
# class CommentMem(models.Model):

#     name = models.CharField(max_length=250, null=False, blank=False)
#     email = models.EmailField()
#     comment = models.TextField(null=False, blank=False)
#     chair = models.ForeignKey(Chair, on_delete=models.CASCADE,
#                                 related_name='commentsmem')
#     date_created = models.DateTimeField(default=timezone.now)
#     date_updated = models.DateTimeField(auto_now=True)
#     approved = models.BooleanField(default=True)

#     class Meta:
#         ordering = ('-date_created',)

#     def __str__(self):
#         return f"Comment by {self.name} on {self.chair}"
