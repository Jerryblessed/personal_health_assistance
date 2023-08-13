from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.utils import timezone
from PIL import Image
from django.conf import settings
import os

Select_CHOICES = (
    ('Basic', 'Basic'),
    ('Standard', 'Standard'),
    ('Premium', 'Premium')
)

def user_directory_path_profile(instance, filename):
    # File will be uploaded to MEDIA_ROOT/user_<id>/<filename>
    profile_pic_name = 'user_{0}/profile.jpg'.format(instance.user.id)
    full_path = os.path.join(settings.MEDIA_ROOT, profile_pic_name)

    if os.path.exists(full_path):
        os.remove(full_path)

    return profile_pic_name

def user_directory_path_banner(instance, filename):
    # File will be uploaded to MEDIA_ROOT/user_<id>/<filename>
    banner_pic_name = 'user_{0}/banner.jpg'.format(instance.user.id)
    full_path = os.path.join(settings.MEDIA_ROOT, banner_pic_name)

    if os.path.exists(full_path):
        os.remove(full_path)

    return banner_pic_name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    location = models.CharField(max_length=50, null=True, blank=True)
    select = models.CharField(choices=Select_CHOICES, max_length=8, verbose_name='Package', null=True, blank=True)
    url = models.CharField(max_length=80, null=True, blank=True, default='abs')
    profile_info = models.TextField(max_length=150, null=True, blank=True)
    created = models.DateField(auto_now_add=True)
    picture = models.ImageField(upload_to=user_directory_path_profile, blank=True, null=True, verbose_name='Picture')
    banner = models.ImageField(upload_to=user_directory_path_banner, blank=True, null=True, verbose_name='Banner')
        # user = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(default='profile-pic-default.jpg',
                              upload_to='profile_pics')
    banner_image = models.ImageField(default='slider-1.jpg',
                                     upload_to='banner')
    job_title = models.CharField(max_length=100, default="tag")
    bio = models.CharField(max_length=100,
                           help_text="Short Bio (eg. I love cats and games)", default="I love reading")

    address = models.CharField(max_length=100,
                               help_text="Enter Your Address",
                               default="tag website")

    city = models.CharField(
                            max_length=100, help_text="Enter Your City"
                            , default="tag city")

    country = models.CharField(max_length=100,
                               help_text="Enter Your Country",
                               default="tag")

    zip_code = models.CharField(max_length=100,
                                help_text="Enter Your Zip Code"
                                , default="tag")

    twitter_url = models.CharField(max_length=250, default="#",
                                   blank=True, null=True,
                                   help_text=
                                   "Enter # if you don't have an account", )
    instagram_url = models.CharField(max_length=250, default="#",
                                     blank=True, null=True,
                                     help_text=
                                     "Enter # if you don't have an account")
    facebook_url = models.CharField(max_length=250, default="#",
                                    blank=True, null=True,
                                    help_text=
                                    "Enter # if you don't have an account", )
    github_url = models.CharField(max_length=250, default="#",
                                  blank=True, null=True,
                                  help_text=
                                  "Enter # if you don't have an account")

    email_confirmed = models.BooleanField(default=False)

    created_on = models.DateTimeField(default=timezone.now)

    updated_on = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.username}'s Profile"


    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        SIZE = (250, 250)

        if self.picture:
            pic = Image.open(self.picture.path)
            pic.thumbnail(SIZE, Image.LANCZOS)
            pic.save(self.picture.path)

    def __str__(self):
        return self.user.username

def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()

post_save.connect(create_user_profile, sender=User)
post_save.connect(save_user_profile, sender=User)
