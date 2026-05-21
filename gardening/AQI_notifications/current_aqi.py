import requests
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

def fetch_aqi():
    api_key = os.getenv('api_key')
    zip_code = os.getenv('zip_code')
    url = f"https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode={zip_code}&distance=100&API_KEY={api_key}"
    
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        if data:
            city = data[0]['ReportingArea']
            aqi = data[0]['AQI']
            print(f"The current AQI in {city} (ZIP {zip_code}) is {aqi}.")
        else:
            print("No data available for the provided ZIP code.")
    else:
        print("Failed to fetch data from AirNow API.")

if __name__ == "__main__":
    fetch_aqi()
