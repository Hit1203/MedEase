from django.shortcuts import render
import json
from django.http import HttpResponse, response, JsonResponse
from .models import Appointment, get_vacant_slots
from authentication.models import User, JWT
from datetime import datetime

# Create your views here.
def create_appointment(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        try:
            doctor = list(User.objects.all().filter(custom_id = body["doctor_id"]))[0]
            patient = list(User.objects.all().filter(custom_id = body["patient_id"]))[0]
            dt = datetime.strptime(body["datetime"], "%d/%m/%Y %H:%M")
            # get_vacant_slots(doctor, dt.date())
            appointment = Appointment.objects.create(doctor = doctor, patient = patient, date_time=dt)
            appointment.save()
            return JsonResponse({"responseData" :{"created": True, 'appointment_id': appointment.custom_id}})
        except:
            return JsonResponse({"responseData" :{"created": False}})

def delete_appointment(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        try:
            appointment = list(Appointment.objects.all().filter(custom_id = body["appointment_id"]))[0]
        except:
            return JsonResponse({"responseData" :{"deleted": False}})
        doctor_id = body["doctor"]
        patient_id = body["patient"]
        if (doctor_id):
            try:
                doctor = list(User.objects.all().filter(custom_id = doctor_id))[0]
            except:
                return JsonResponse({"responseData" :{"deleted": False}})
            if(not doctor.is_doctor or (appointment.doctor != doctor)):
                return JsonResponse({"responseData" :{"deleted": False}})
            else:
                appointment.delete()
                return JsonResponse({"responseData" :{"deleted": True}})
        elif (not doctor_id) and patient_id:
            try:
                patient = list(User.objects.all().filter(custom_id = patient_id))[0]
            except:
                return JsonResponse({"responseData" :{"deleted": False}})
            if(patient.is_doctor or (appointment.patient != patient)):
                return JsonResponse({"responseData" :{"deleted": False}})
            else:
                appointment.delete()
                return JsonResponse({"responseData" :{"deleted": True}})
        else:
            return JsonResponse({"responseData" :{"deleted": False}})
        