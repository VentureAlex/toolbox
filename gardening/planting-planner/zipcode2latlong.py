from geopy.geocoders import Nominatim
import requests

def zip_to_coordinates(zip_code):
    geolocator = Nominatim(user_agent="zip_to_coordinates")
    location = geolocator.geocode(zip_code)
    if location:
        return location.latitude, location.longitude
    else:
        return None, None

# Example usage:
zip_code = input("Enter zip code: ")
latitude, longitude = zip_to_coordinates(zip_code)
if latitude is not None and longitude is not None:
    response = requests.get(f"https://api.weather.gov/points/{latitude},{longitude}")
    if response.status_code == 200:
        # Extract the latitude and longitude from the response JSON
        data = response.json()
        try:
            latitude = data['geometry']['coordinates'][1]  # Extract latitude
            longitude = data['geometry']['coordinates'][0]  # Extract longitude
            print(f"Latitude: {latitude}, Longitude: {longitude}")
        except KeyError as e:
            print("Error accessing latitude/longitude:", e)
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
else:
    print("Invalid zip code or unable to retrieve coordinates.")
