from blog.models.counter_model import Click
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.shortcuts import render


@login_required
def increment_click(request):
    click, created = Click.objects.get_or_create(user=request.user)
    click.count += 1
    click.save()
    return render(request, 'blog/counter/counter.html', {'click_count': click.count})
#    return JsonResponse({'click_count': click.count})
