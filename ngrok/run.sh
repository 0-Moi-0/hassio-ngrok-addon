#!/bin/bash

# Limpiando Codigo
clear

# Borra el complemento y vuélvelo a agregar
echo "Preparando Repositorios de Ngrok..."
rm -rf /data/addons/local/ngrok
rm -rf /addons/local/ngrok
sleep 2  # Espera 2 segundos
# Clonar el complemento
cd /addons
git clone https://github.com/0-Moi-0/hassio-ngrok-addon ngrok
sleep 2  # Espera 2 segundos
# Recargar el complemento
ha addons reload

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

# Extraer valores del archivo de opciones
echo "Paso 8: Activando Ngrok con authtoken: $AUTHTOKEN"
CONFIG_PATH=/data/options.json
AUTHTOKEN=$(jq --raw-output '.authtoken // "VACIO"' "$CONFIG_PATH")
echo "El token obtenido es: $AUTHTOKEN"
sleep 2  # Espera 2 segundos
if [ "$AUTHTOKEN" = "VACIO" ]; then
  echo "❌ ERROR: No se encontró un authtoken en el archivo de configuración."
  exit 1
fi

echo "✅ Usando authtoken: $AUTHTOKEN"
bash -c "ngrok config add-authtoken "$AUTHTOKEN""

sleep 5  # Espera 5 segundos

# Cerrar cualquier sesión previa de Ngrok
echo "Paso 9: Cerrando sesiones previas de Ngrok..."
bash -c "pkill -f ngrok"
sleep 5  # Espera 5 segundos

echo "Iniciando túnel en $NGROK_URL"
NGROK_URL=$(jq --raw-output '.ngrok_url' $CONFIG_PATH)
echo "El DNS obtenido es: $NGROK_URL"
sleep 2  # Espera 2 segundos
bash -c "exec ngrok http --url=$NGROK_URL 8123"

echo "Ngrok está corriendo y Home Assistant es accesible a través de la URL proporcionada por Ngrok."

# Mantiene el contenedor en ejecución
tail -f /dev/null
