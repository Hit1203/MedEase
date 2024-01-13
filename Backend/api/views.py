from django.shortcuts import render
from appointments.models import get_vacant_slots, Appointment
from datetime import datetime
from authentication.models import User
import json
from django.http import HttpResponse, response, JsonResponse

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
        return JsonResponse({"responseData" :{"vacant_doctors": vacant}})

def get_vacant_slots_view(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        date = datetime.strptime(body["date"], "%d/%m/%Y").date()
        doctor = list(User.objects.all().filter(custom_id = body['doctor']))[0]
        vacant = get_vacant_slots(doctor=doctor, date=date)
        return JsonResponse({"responseData" :{"vacant_slots": vacant}})

def get_patient_appointments(request):
    if(request.method == 'POST'):
        body = json.loads(request.body.decode('utf-8'))
        patiend_id = body["patient"]
        try:
            patient = list(User.objects.all().filter(custom_id = patiend_id))[0]
            appointments = list(Appointment.objects.all().filter(patient = patient, date_time__gte = datetime.now()))
            upcoming = []
            for a in appointments:
                upcoming.append({"doctor" :a.doctor.custom_id, "d_name": a.doctor.fullname, "date_time": a.date_time.strftime("%d/%m/%Y %H:%M"), "custom_id": a.custom_id, "patient": a.patient.custom_id})
            return JsonResponse({"responseData": {"valid_user": True , "appointments": upcoming}})
        except:
            return JsonResponse({"responseData": {"valid_user": False }})

def get_user_data(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        user_id = body['custom_id']
        jwt = body["jwt"]
        try:
            user = list(User.objects.all().filter(custom_id = user_id))[0]
            nwwd = list(map(lambda x: x.strip(), user.non_working_week_days[1:-1].split(",")))
            return JsonResponse({"responseData" :{"created": True, 'user_id': str(user.custom_id), 'is_doctor': user.is_doctor, 'fullname': user.fullname, 'gender': user.gender, 'age': user.age, 'height': user.height, 'weight': user.weight, 'blood_group': user.blood_group, 'qualification': user.qualification, 'wh_start': user.wh_start, 'wh_end': user.wh_end, 'non_working_week_days': [] if not user.is_doctor else nwwd, 'email': user.email}})
        except:
            return JsonResponse({"responseData": {"success": False}})

def get_doctor_appointments(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        user_id = body['custom_id'] 
        try:
            doctor = list(User.objects.all().filter(custom_id = user_id))[0]
            appointments = list(Appointment.objects.all().filter(doctor = doctor, date_time__gte = datetime.now()))
            upcoming = []
            for a in appointments:
                upcoming.append({"doctor" :a.doctor.custom_id, "d_name": a.doctor.fullname, "date_time": a.date_time.strftime("%d/%m/%Y %H:%M"), "custom_id": a.custom_id, "patient": a.patient.custom_id, "patient_name": a.patient.fullname})
            return JsonResponse({"responseData": {"valid_user": True , "appointments": upcoming}})
        except:
            return JsonResponse({"responseData": {"valid_user": False }})

def get_doctors(request):
   if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        users = list(User.objects.all())
        doctors = []
        for user in users:
            if(user.is_doctor):
                doctors.append({"custom_id": user.custom_id, "fullname": user.fullname, "medical_id": user.qualification, "gender": user.gender, "wh_start": user.wh_start, "wh_end": user.wh_end, "holiday_days": user.non_working_week_days})
        return JsonResponse({"responseData": {"doctors": doctors}})

  

        