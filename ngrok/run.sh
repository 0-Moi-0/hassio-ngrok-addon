#!/bin/bash

#Declaracion de variables
# Ruta al archivo config.json del complemento
CONFIG_PATH="/config/addons/config/ngrok/config.json"

# Leer los valores de authtoken y ngrok_url desde el archivo config.json
AUTHTOKEN=$(jq --raw-output '.options.authtoken' $CONFIG_PATH)
NGROK_URL=$(jq --raw-output '.options.ngrok_url' $CONFIG_PATH)

# Asegurarse de que las variables no estén vacías
if [[ -z "$AUTHTOKEN" || -z "$NGROK_URL" ]]; then
  echo "ERROR: AUTHTOKEN o NGROK_URL no están definidos en el archivo config.json."
  exit 1
fi



# Instalar sshpass si no está instalado
apt-get update
apt-get install -y sshpass
# Iniciar SSh en AH con credenciales de acceso
sshpass -p "Inicio2025" ssh -o StrictHostKeyChecking=no hassio@homeassistant.local << EOF

# Limpiando Codigo
clear

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

# Extraer valores del archivo de opciones EIMINAR ESTE CODIGO
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
ngrok config add-authtoken "$AUTHTOKEN"

sleep 5  # Espera 5 segundos

# Cerrar cualquier sesión previa de Ngrok
echo "Paso 9: Cerrando sesiones previas de Ngrok..."
pkill -f ngrok
#bash -c "pkill -f ngrok"
sleep 5  # Espera 5 segundos

# Iniciando Tunel Ngrok ELIMINAR ESTE CODIGO
echo "Iniciando túnel en $NGROK_URL"
NGROK_URL=$(jq --raw-output '.ngrok_url' $CONFIG_PATH)
echo "El DNS obtenido es: $NGROK_URL"
sleep 2  # Espera 2 segundos

ngrok http --url=$NGROK_URL 8123
tail -f /dev/null # Mantiene el contenedor en ejecución
echo "Ngrok está corriendo y Home Assistant es accesible a través de la URL proporcionada por Ngrok."


