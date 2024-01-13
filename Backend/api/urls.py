from django.urls import path
from django.views.decorators.csrf import csrf_exempt

from .views import get_vacant_doctors, get_vacant_slots_view, get_patient_appointments, get_user_data, get_doctor_appointments, get_doctors

urlpatterns = [
    path('get-vacant-doctors/',  csrf_exempt(get_vacant_doctors)),
    path('get-vacant-slots/', csrf_exempt(get_vacant_slots_view)),
    path('get-user-appointments/', csrf_exempt(get_patient_appointments)),
    path('get-user-data/', csrf_exempt(get_user_data)),
    path('get-doctor-appointments/', csrf_exempt(get_doctor_appointments)),
    path('get-doctors/', csrf_exempt(get_doctors)),
]