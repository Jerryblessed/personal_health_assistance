from django.db import models
from django.db.models import Max

from django.contrib.auth.models import User

class Livestream(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='livestreams_sent')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='livestreams_sent_as_sender')
    recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='livestreams_received')
    body = models.TextField(null=True)  # Add the 'body' field
    is_read = models.BooleanField(default=False)  # Add the 'is_read' field
    date = models.DateTimeField(null=True, editable=False)

    @staticmethod
    def send_livestream(from_user, to_user, body):
        sender_livestream = Livestream(
            user=from_user,
            sender=from_user,
            recipient=to_user,
            body=body,
            is_read=True
        )
        sender_livestream.save()

        recipient_livestream = Livestream(
            user=to_user,
            sender=from_user,
            recipient=from_user,
            body=body
        )
        recipient_livestream.save()
        return sender_livestream

    @staticmethod
    def get_livestreams(user):
        livestreams = (
            Livestream.objects
            .filter(user=user)
            .values('recipient')
            .annotate(last=Max('date'))
            .order_by('-last')
        )
        users = []
        for livestream in livestreams:
            users.append({
                'user': User.objects.get(pk=livestream['recipient']),
                'last': livestream['last'],
                'unread': Livestream.objects.filter(
                    user=user,
                    recipient__pk=livestream['recipient'],
                    is_read=False
                ).count()
            })
        return users
