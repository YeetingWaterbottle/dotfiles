import requests

response = requests.get("https://google.com/")

response.raise_for_status()

print(response.text)
