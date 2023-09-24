from datetime import datetime, timedelta

start_time = datetime.strptime("09:00", "%H:%M")
end_time = datetime.strptime("18:00", "%H:%M")
curr_time = start_time
vacant_slots = []

print(type(start_time))

def isAvailable(start_time, doctor):
    return True

while(curr_time < end_time):
    if(isAvailable(curr_time, "Mori")):
        (curr_time.time().strftime("%H:%M"))
    curr_time = curr_time + timedelta(minutes=30)
