from django.shortcuts import render
import json
from django.http import HttpResponse, response, JsonResponse
from .models import Appointment
from authentication.models import User, JWT
from datetime import datetime

# Create your views here.
def create_appointment(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        doctor = list(User.objects.all().filter(custom_id = body["doctorID"]))[0]
        patient = list(User.objects.all().filter(custom_id = body["patientID"]))[0]
        dt = datetime.strptime(body["dateTime"], "%d/%m/%Y %H:%M")
        appointment = Appointment.objects.create(doctor = doctor, patient = patient, date_time=dt)
        # appointment.doctor = doctor
        # appointment.patient = patient
        # appointment.date_time = dt
        appointment.save()
        print(appointment.date_time)
        return JsonResponse({"responseData" :{"created": True}})