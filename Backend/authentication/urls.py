from django.contrib import admin
from django.urls import path
from .views import register, login, is_logged_in, forgot_password, change_forgotten_passwrd
from django.views.decorators.csrf import csrf_exempt

urlpatterns = [
    path('signup/', csrf_exempt(register)),
    path('login/', csrf_exempt(login)),
    path('is-logged-in/', csrf_exempt(is_logged_in)),
    path('forgot-password/', csrf_exempt(forgot_password)),
    
]