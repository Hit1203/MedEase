from django.urls import path
from django.views.decorators.csrf import csrf_exempt

from .views import create_appointment

urlpatterns = [
    path('create/',  csrf_exempt(create_appointment)),
]