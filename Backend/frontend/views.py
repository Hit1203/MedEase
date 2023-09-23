from django.shortcuts import render
import json
from authentication.models import User, PRToken
from django.http import HttpResponse, response, JsonResponse

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
            print(e)
            return JsonResponse({"responseData": {"validToken": False}})
    