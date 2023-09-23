from django.test import TestCase

# Create your tests here.
from authentication.models import User
from appointments.models import Appointment

class Appointment__TC(TestCase):
    def setUp(self):
        pass
    def getAllAppointments(self):
        doctor = User.objects.all.filter(custom_id = "RQXWZCNIMXXWMVOMWXTT")
        print(doctor)
        print(Appointment.objects.all().filter(doctor = doctor))
