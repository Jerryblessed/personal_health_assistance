from django.contrib.auth.models import User
from django.db import models

class Click(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)

    def __str__(self):
        return f"Click count for {self.user.username}"
