from django.urls import path
from django.views.decorators.csrf import csrf_exempt

from .views import get_vacant_doctors, get_vacant_slots_view

urlpatterns = [
    path('get-vacant-doctors/',  csrf_exempt(get_vacant_doctors)),
    path('get-vacant-slots/', csrf_exempt(get_vacant_slots_view)),
]