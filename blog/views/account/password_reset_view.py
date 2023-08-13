# Django imports
from django.contrib.auth import logout
from django.contrib import messages
from django.shortcuts import render, redirect
from django.views.generic import View


class Passwordreset(View):
    """
     Logs user out of the dashboard.
    """
    template_name = 'account/password_reset.html'

