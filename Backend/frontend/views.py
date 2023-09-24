from django.shortcuts import render
import json
from authentication.models import User, PRToken, JWT
from django.http import HttpResponse, response, JsonResponse
from django.contrib.auth import authenticate
from appointments.models import Appointment
from datetime import datetime

# Create your views here.

INDEX_HTML_PATH = "frontend/templates/frontend/index.html"

def index(request):
    if request.method == "GET":
        return render(request, 'frontend/index.html')

def change_forgotten_passwrd(request, token):
    if(request.method == 'GET'):
        return render(request, 'frontend/index.html')
    elif(request.method == "POST"):
        body = json.loads(request.body.decode('utf-8'))
        try:
            prToken = PRToken.objects.get(token = token)
            user = User.objects.get(prtoken = prToken)
            new_pass = body["newPassword"]
            user.set_password(new_pass)
            user.save()
            return JsonResponse({"responseData": {"validToken": True}})
        except Exception as e:
            return JsonResponse({"responseData": {"validToken": False}})

def admin(request):
    if request.method == "GET":
        return render(request, 'frontend/index.html')

def admin_login(request):
    if request.method == "GET":
        return render(request, 'frontend/index.html')
    elif request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        email = body["email"]
        password = body["password"]
        if(authenticate(email=email, password=password)):
            user = User.objects.all().filter(email=email)
            if(not user[0].is_superuser):
                return JsonResponse({"responseData" : {"isAuthenticated": False}})
            jwt = JWT.objects.all().filter(user = user[0])
            for token in jwt:
                token.delete()
            jwt = JWT.objects.create(user = user[0])
            response = JsonResponse({"responseData" :{"isAuthenticated": True, "token": str(jwt.token), 'user_id': str(user[0].custom_id)}})
            response.set_cookie(key="token", value=jwt.token, max_age=1*60*60)
            return response
        else:
            return JsonResponse({"responseData" : {"isAuthenticated": False}})

def get_all_patients(request):
    if(request.method == 'POST'):
        body = json.loads(request.body.decode('utf-8'))
        jwt = body["jwt"]
        # try:
        jwt = JWT.objects.get(token = jwt)
        user = User.objects.get(jwt = jwt)
        if(user.is_superuser):
            users = list(User.objects.all())
            patients = []
            for patient in users:
                if(patient.is_doctor == False):
                    patients.append({'custom_id': patient.custom_id, "fullname": patient.fullname, "age": patient.age, "gender": patient.gender, "weight": patient.weight, "height": patient.height, "blood_group": patient.blood_group})
            return JsonResponse({"responseData": {"success": True, "patients": patients}})
        else:
            return JsonResponse({"responseData": {"success": False}})

def get_upcoming_appointments(request):
    if(request.method == 'POST'):
        body = json.loads(request.body.decode('utf-8'))
        jwt = body["jwt"]
        jwt = JWT.objects.get(token = jwt)
        user = User.objects.get(jwt = jwt)
        if(user.is_superuser):
            appointments = list(Appointment.objects.all().filter(date_time__gte = datetime.now()).order_by('date_time'))
            ua = []
            for appointment in appointments:
                ua.append({"custom_id": appointment.custom_id, "doctor_name": "Dr. " + appointment.doctor.fullname, "doctor_id": appointment.doctor.custom_id, "patient_name": ("Mr. " + appointment.patient.fullname) if (appointment.patient.gender == 'Male') else ("Mrs. " + appointment.patient.fullname), "patient_id": appointment.patient.custom_id, "time": appointment.date_time.strftime("%d/%m/%Y %H:%M")})
            return JsonResponse({"responseData": {"success": True, "appointments": ua}})
        else:
            return JsonResponse({"responseData": {"success": False}})

def admin_delete_appointment(request):
    if(request.method == 'POST'):
        body = json.loads(request.body.decode('utf-8'))
        jwt = body["jwt"]
        # try:
        jwt = JWT.objects.get(token = jwt)
        user = User.objects.get(jwt = jwt)
        if(user.is_superuser):
            app_id = body["custom_id"]
            appointment = list(Appointment.objects.all().filter(custom_id = app_id))[0]
            appointment.delete__(initiator="Admin")
            return JsonResponse({"responseData": {"authorized": True, "deleted": True}})
        else:
            return JsonResponse({"responseData": {"authorized": False}})
