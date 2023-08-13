from django.contrib import admin

# Register your models here.
from page.models import Page, PostFileContent

admin.site.register(Page)
admin.site.register(PostFileContent)