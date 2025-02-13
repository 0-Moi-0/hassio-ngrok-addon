#!/bin/bash

# Navegar a la carpeta /config
cd /config/
echo "Paso 1: Cambiando al directorio /config"
sleep 5  # Espera 5 segundos

# Descargar Ngrok
echo "Paso 2: Descargando Ngrok..."
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip
sleep 5  # Espera 5 segundos

# Descomprimir el archivo
echo "Paso 3: Descomprimiendo Ngrok..."
yes | unzip ngrok-stable-linux-arm.zip
sleep 5  # Espera 5 segundos

# Eliminar el archivo ZIP
echo "Paso 4: Eliminando el archivo ZIP..."
rm ngrok-stable-linux-arm.zip
sleep 5  # Espera 5 segundos

# Dar permisos de ejecución al binario de ngrok
echo "Paso 5: Dando permisos de ejecución a Ngrok..."
chmod +x /config/ngrok
sleep 5  # Espera 5 segundos

# Agregar /config al PATH
echo "Paso 6: Agregando /config al PATH..."
echo 'export PATH=$PATH:/config' >> ~/.bashrc
sleep 2  # Espera 2 segundos

# Aplicar los cambios al bashrc
echo "Paso 7: Aplicando los cambios..."
source ~/.bashrc
sleep 2  # Espera 2 segundos

# Cerrar cualquier sesión previa de Ngrok
echo "Paso 9: Cerrando sesiones previas de Ngrok..."
pkill -f ngrok
sleep 5  # Espera 5 segundos


echo "Ngrok está corriendo y Home Assistant es accesible a través de la URL proporcionada por Ngrok."




# Lee el authtoken desde la configuración
AUTHTOKEN=$(jq -r '.authtoken' /config/ngrok/config.json)
NGROK_URL=$(jq -r '.ngrok_url' /config/ngrok/config.json)

# Configura el authtoken
ngrok config add-authtoken "$AUTHTOKEN"

# Ejecuta el túnel de Ngrok
ngrok http --hostname="$NGROK_URL" 8123
