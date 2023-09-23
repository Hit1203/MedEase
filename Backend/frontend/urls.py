
from django.urls import path, include
from django.views.decorators.csrf import csrf_exempt
from .views import index, change_forgotten_passwrd

urlpatterns = [
    path('', csrf_exempt(index)),
    path('change-forgotten-password/<token>/', csrf_exempt(change_forgotten_passwrd))
]