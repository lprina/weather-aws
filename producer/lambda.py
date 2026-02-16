import json
import boto3
import requests
import os
from datetime import datetime

s3 = boto3.client("s3")

BUCKET = os.environ["BUCKET"]
API_KEY = os.environ["API_KEY"]
LAT = os.environ["LATITUDE"]
LON = os.environ["LONGITUDE"]

def lambda_handler(event, context):

    url = f"https://api.openweathermap.org/data/3.0/onecall?lat={LAT}&lon={LON}&exclude=hourly,daily,current&units=metric&appid={API_KEY}"

    response = requests.get(url)
    data = response.json()

    key = f"weather/{datetime.utcnow().strftime('%Y%m%d_%H%M%S')}.json"

    s3.put_object(
        Bucket=BUCKET,
        Key=key,
        Body=json.dumps(data),
        ContentType="application/json"
    )

    return {"status": "ok"}
