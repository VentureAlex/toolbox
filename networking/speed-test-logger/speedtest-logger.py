# https://pythonprogramming.org/monitor-your-internet-with-python/

import os
import speedtest
import datetime
import csv
import time

# Create the directory if it doesn't exist
directory = "./speedtest-output"
if not os.path.exists(directory):
    os.makedirs(directory)

s = speedtest.Speedtest()

with open(f'{directory}/speed_test.csv', mode='w') as speedcsv:
    csv_writer = csv.DictWriter(speedcsv, fieldnames=['time', 'downspeed', 'upspeed'])
    csv_writer.writeheader()
    while True:
        time_now = datetime.datetime.now().strftime("%H:%M:%S")
        downspeed = round((round(s.download()) / 1048576), 2)
        upspeed = round((round(s.upload()) / 1048576), 2)
        csv_writer.writerow({
            'time': time_now,
            'downspeed': downspeed,
            "upspeed": upspeed
        })
        # 60 seconds sleep
        time.sleep(60)