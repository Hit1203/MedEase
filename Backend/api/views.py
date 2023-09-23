from django.shortcuts import render
from appointments.models import get_vacant_slots
from datetime import datetime
from authentication.models import User
import json
from django.http import HttpResponse, response, JsonResponse
# Create your views here.

def get_vacant_doctors(request):
    if(request.method == 'POST'):
        vacant = []
        body = json.loads(request.body.decode('utf-8'))
        date = datetime.strptime(body["date"], "%d/%m/%Y")
        users = User.objects.all()
        doctors = []
        for user in users:
            if(user.is_doctor):
                doctors.append(user)
        for doctor in doctors:
            vs = get_vacant_slots(doctor=doctor, date=date)
            if len(vs) > 0:
                vacant.append({"id" : doctor.custom_id, "name": doctor.fullname})
        print(date)
        return JsonResponse({"responseData" :{"vacant_doctors": vacant}})

def get_vacant_slots_view(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        date = datetime.strptime(body["date"], "%d/%m/%Y").date()
        doctor = list(User.objects.all().filter(custom_id = body['doctor']))[0]
        vacant = get_vacant_slots(doctor=doctor, date=date)
        return JsonResponse({"responseData" :{"vacant_slots": vacant}})