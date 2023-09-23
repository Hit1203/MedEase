from django.db import models
from authentication.models import User, JWT
import random
import string

id_length = 20

token_length = 34

def make_custom_user_id():
    satisfied = False
    while not satisfied:
        custom_string = ''.join(random.choice(
            string.ascii_uppercase) for _ in range(id_length))
        check_list = list(Appointment.objects.filter(custom_id=custom_string))
        if len(check_list) == 0:
            satisfied = True

    return custom_string

# Create your models here.
class Appointment(models.Model):
    # date time patient doctor 
    custom_id = models.CharField(
        max_length=id_length, null=False, blank=False, editable=False, unique=True)
    patient = models.ForeignKey(User, related_name='A_Doctor', on_delete=models.CASCADE)
    doctor = models.ForeignKey(User, related_name='A_Patient', on_delete=models.CASCADE)
    date_time = models.DateTimeField(null=False, blank=False)

    def save(self, *args, **kwargs):
        if((self.doctor.is_doctor == False) and (self.patient.is_doctor == True)):
            raise ValueError("Users dont have valid roles.")
        if self.custom_id == '' or self.custom_id is None:
            self.custom_id = make_custom_user_id()
        super(Appointment, self).save(*args, **kwargs)

    def __str__(self):
        return f"{self.patient} -> {self.doctor} at {self.date_time}"