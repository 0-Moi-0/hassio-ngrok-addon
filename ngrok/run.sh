#!/bin/bash

# Lee el authtoken desde la configuración
AUTHTOKEN=$(jq -r '.authtoken' /config/ngrok/config.json)
NGROK_URL=$(jq -r '.ngrok_url' /config/ngrok/config.json)

# Configura el authtoken
ngrok config add-authtoken "$AUTHTOKEN"

# Ejecuta el túnel de Ngrok
ngrok http --hostname="$NGROK_URL" 8123
