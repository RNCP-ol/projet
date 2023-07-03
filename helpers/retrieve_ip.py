import requests

try:
  response = requests.get('https://api.ipify.org/?format=json', timeout=10)
  print("Adresse IP publique :", response.json()['ip'])
except requests.RequestException:
  print("Impossible de récupérer l'adresse IP publique")
