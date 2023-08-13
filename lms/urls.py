

from django.urls import path
from .views import *

urlpatterns = [
    path('index/',indexshow,name='indexshow'),
    path('', land, name='land'),
    path('contact/',contact,name='contact'),
    path('team/',team,name='team'),
    path('about/',about,name='about'),
]
