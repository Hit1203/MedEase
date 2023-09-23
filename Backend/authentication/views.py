from django.core.mail import EmailMessage, get_connection
from django.shortcuts import render, redirect
from django.core.mail import send_mail, BadHeaderError
from django.http import HttpResponse, response, JsonResponse
from django.contrib.auth.forms import PasswordResetForm
from django.template.loader import render_to_string
from django.utils.http import urlsafe_base64_encode
from django.contrib.auth.tokens import default_token_generator
from django.contrib.auth import authenticate
import json
from django.contrib.auth import get_user_model
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.sites.shortcuts import get_current_site
from django.core.mail import send_mail
from django.views.decorators.csrf import ensure_csrf_cookie
from .models import User, JWT, PRToken
from django.db import IntegrityError
from django.core.mail import send_mail
import Backend.settings as settings


# Create your views here.
def register(request):
    if request.method == 'POST':
        body = json.loads(request.body.decode('utf-8'))
        # print(body)
        gender = body["gender"].capitalize()
        email = body["email"]
        password = body["password"]
        fullname = body["fullname"]
        is_doctor = body["is_doctor"]
        # print(is_doctor)
        if(is_doctor):
            qualification = body["qualification"]
            wh_start = body["wh_start"]
            wh_end = body["wh_end"]
            non_working_week_days = body["non_working_week_days"]
            try : 
                user = User.objects.create_user(email = email, password = password)
                jwt = JWT.objects.create(user = user)
                user.qualification = qualification
                user.wh_start = wh_start
                user.wh_end = wh_end
                user.fullname= fullname
                user.is_doctor = is_doctor
                user.gender = gender
                user.non_working_week_days = non_working_week_days
                user.save()
                return JsonResponse({"responseData" :{"created": True, "token": str(jwt.token)}})
            except Exception as e:
                return JsonResponse({"responseData" : {"created": False}})
        else:
            weight = body["weight"]
            height = body["height"]
            age = body["age"]
            blood_group = body["blood_group"]
            try : 
                user = User.objects.create_user(email = email, password = password)
                jwt = JWT.objects.create(user = user)
                user.age = age
                user.weight = weight
                user.height = height
                user.fullname = fullname
                user.is_doctor = is_doctor
                user.gender = gender
                user.blood_group = blood_group
                user.save()
                return JsonResponse({"responseData" :{"created": True, "token": str(jwt.token)}})
            except Exception as e:
                print(e)
                return JsonResponse({"responseData" : {"created": False}})
        

def login(request):
    if request.method == "POST":
        body=json.loads(request.body.decode("utf-8"))
        email = body["email"]
        password = body["password"]
        if(authenticate(email=email, password=password)):
            user = User.objects.all().filter(email=email)
            jwt = JWT.objects.all().filter(user = user[0])
            for token in jwt:
                token.delete()
            jwt = JWT.objects.create(user = user[0])
            return JsonResponse({"responseData" :{"isAuthenticated": True, "token": str(jwt.token), 'is_doctor': user[0].is_doctor}})
        else:
            return JsonResponse({"responseData" : {"isAuthenticated": False}})

def is_logged_in(request):
    if(request.method == "POST"):
        print(request.headers)
        jwt_token = request.headers['Authorization']
        try:
            jwt = JWT.objects.get(token = jwt_token)
            user = User.objects.get(jwt = jwt)
            print(user)
            return JsonResponse({"responseData" :{"isLoggedIn": True, "userID": str(user.custom_id), "userEmail" : str(user)}})
        except Exception as e:
            print(e)
            return JsonResponse({"responseData" :{"isLoggedIn": False}})

def forgot_password(request):
    if (request.method=="GET") :
        pass
    elif (request.method == "POST"):
        body=json.loads(request.body.decode("utf-8"))
        try:
            user = User.objects.get(email = body["email"])
        except Exception as e:
            print(e)
            return JsonResponse({"responseData" :{"emailValid": False, "emailSent": False}})
        try:
            prevTokens = PRToken.objects.all().filter(user = user)
            for token in prevTokens:
                token.delete()
            prToken = PRToken.objects.create(user= user)
            
            with get_connection(  
                host=settings.EMAIL_HOST, 
                port=settings.EMAIL_PORT,  
                username=settings.EMAIL_HOST_USER, 
                password=settings.EMAIL_HOST_PASSWORD, 
                use_tls=settings.EMAIL_USE_TLS  
                ) as connection: 
                print(body["email"])
                EmailMessage(
                "Subject here",
                f"Link : {settings.WEBSITE_URL}/change-forgotten-password/{str(prToken.token)}/",
                settings.EMAIL_HOST_USER,
                [user.email],
                connection=connection,
        ).send()   
            return JsonResponse({"responseData" :{"emailValid": True, "emailSent" : True}})
        except Exception as e:
            print(e)
            return JsonResponse({"responseData":{"emailValid":False,"emailSent":False}})

def change_forgotten_passwrd(request, token):
    if(request.method == 'GET'):
        pass
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
            print(e)
            return JsonResponse({"responseData": {"validToken": False}})