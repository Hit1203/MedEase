from django.urls import path, include
from django.views.decorators.csrf import csrf_exempt
from .views import index, change_forgotten_passwrd, admin, admin_login, get_all_patients, get_upcoming_appointments, admin_delete_appointment

urlpatterns = [
    path('change-forgotten-password/<token>/', csrf_exempt(change_forgotten_passwrd)),
    path('help/', csrf_exempt(index)),
    path('admin-panel/', csrf_exempt(admin)),
    path('admin-panel/login/', csrf_exempt(admin_login)),
    path('admin-get-all-patients/', csrf_exempt(get_all_patients)),
    path('admin-get-upcoming-appointments/', csrf_exempt(get_upcoming_appointments)),
    path('admin-delete-appointment/', csrf_exempt(admin_delete_appointment)),
]