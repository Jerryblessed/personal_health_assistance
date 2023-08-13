from django.contrib import admin
from assignment.models import Assignment, Submission, AssignmentFileContent
# Register your models here.

admin.site.register(Assignment)
admin.site.register(Submission)
admin.site.register(AssignmentFileContent)