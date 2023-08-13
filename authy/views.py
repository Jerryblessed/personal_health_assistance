from django.shortcuts import render, redirect, get_object_or_404
from authy.forms import SignupForm, ChangePasswordForm, EditProfileForm
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth import update_session_auth_hash
from authy.models import Profile
from django.template import loader
from django.http import HttpResponse
from django.contrib.auth.models import auth
from django.contrib import messages

# Create your views here.
from django.views.generic import View
from django.contrib.auth.mixins import LoginRequiredMixin
from blog.forms.dashboard.author.author_forms import (
    UserUpdateForm,
    ProfileUpdateForm,
)



def SideNavInfo(request):
	user = request.user
	nav_profile = None

	if user.is_authenticated:
		nav_profile = Profile.objects.get(user=user)

	return {'nav_profile': nav_profile}


def UserProfile(request, username):
	user = get_object_or_404(User, username=username)
	profile = Profile.objects.get(user=user)

	template = loader.get_template('registration/edit_profile.html')

	context = {
		'profile':profile,

	}

	return HttpResponse(template.render(context, request))


def Signup(request):
	if request.method == 'POST' and 'action' in request.POST:
		form = SignupForm(request.POST)
		if form.is_valid():
			username = form.cleaned_data.get('username')
			email = form.cleaned_data.get('email')
			password = form.cleaned_data.get('password')
			User.objects.create_user(username=username, email=email, password=password)
			messages.info(request,"Your account has been successfully Registered, Now you LogIn ")
			return redirect('login')
	else:
		form = SignupForm()
		if request.user.is_authenticated:
			return redirect('index')
		else:
			if request.method == 'POST' and 'Signin' in request.POST:
				username = request.POST['username']
				password = request.POST['password']
				user = auth.authenticate(username=username, password=password)
				if user is not None:
					auth.login(request, user)
					return redirect('index')
				else:
					messages.error(request,"*Invalid User, Please Try Again & SignUp")
	context = {'formsign': form,}
	return render(request, 'temp/sign.html', context)



@login_required
def PasswordChange(request):
	user = request.user
	if request.method == 'POST':
		form = ChangePasswordForm(request.POST)
		if form.is_valid():
			new_password = form.cleaned_data.get('new_password')
			user.set_password(new_password)
			user.save()
			update_session_auth_hash(request, user)
			return redirect('change_password_done')
	else:
		form = ChangePasswordForm(instance=user)

	context = {
		'form':form,
	}

	return render(request, 'registration/change_password.html', context)


def PasswordChangeDone(request):
	return render(request, 'registration/change_password_done.html')


@login_required
def EditProfile(request):
	user = request.user.id
	profile = Profile.objects.get(user__id=user)
	user_basic_info = User.objects.get(id=user)

	if request.method == 'POST':
		form = EditProfileForm(request.POST, request.FILES, instance=profile)
		if form.is_valid():
			profile.picture = form.cleaned_data.get('picture')
			profile.banner = form.cleaned_data.get('banner')
			user_basic_info.first_name = form.cleaned_data.get('first_name')
			user_basic_info.last_name = form.cleaned_data.get('last_name')
			# profile.location = form.cleaned_data.get('location')
			# profile.url = form.cleaned_data.get('url')
			profile.profile_info = form.cleaned_data.get('profile_info')
			profile.save()
			user_basic_info.save()
			return redirect('index')
	else:
		form = EditProfileForm(instance=profile)

	context = {
		'form':form,
	}

	return render(request, 'index.html', context)

class AuthorProfileView(LoginRequiredMixin, View):
    """
    Displays author profile details
    """
    template_name = "dashboard/author/author_profile_detail.html"
    context_object = {}

    def get(self, request):
        author = User.objects.get(username=request.user)

        self.context_object['author_profile_details'] = author
        return render(request, self.template_name, self.context_object)

class AuthorProfileUpdateView(LoginRequiredMixin, View):
    """
     Updates author profile details
    """
    template_name = 'dashboard/author/author_profile_update.html'
    context_object = {}

    def get(self, request):
        user_form = UserUpdateForm(instance=self.request.user)
        profile_form = ProfileUpdateForm(instance=self.request.user.profile)

        self.context_object['user_form'] = user_form
        self.context_object['profile_form'] = profile_form

        return render(request, self.template_name, self.context_object)

    def post(self, request, *args, **kwargs):
        user_form = UserUpdateForm(data=request.POST, instance=self.request.user)
        profile_form = ProfileUpdateForm(data=request.POST, files=request.FILES,
                                         instance=self.request.user.profile)

        if user_form.is_valid() and profile_form.is_valid():

            user_form.save()
            profile_form.save()

            messages.success(request, f'Your account has successfully '
                                      f'been updated!')
            return redirect('blog:author_profile_details')

        else:
            user_form = UserUpdateForm(instance=self.request.user)
            profile_form = ProfileUpdateForm(instance=self.request.user.profile)

            self.context_object['user_form'] = user_form
            self.context_object['profile_form'] = profile_form

            messages.error(request, f'Invalid data. Please provide valid data.')
            return render(request, self.template_name, self.context_object)



