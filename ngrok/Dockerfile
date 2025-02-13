# Usa una imagen base de Alpine
FROM alpine:3.18

# Instala las dependencias necesarias (wget, unzip, bash)
RUN apk update && apk add --no-cache wget unzip bash

# Navega a la carpeta /config y realiza las acciones
WORKDIR /config

# Descargar Ngrok
RUN echo "Paso 1: Descargando Ngrok..." && \
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip && \
    sleep 5  && \
    echo "Paso 2: Descomprimiendo Ngrok..." && \
    unzip ngrok-stable-linux-arm.zip && \
    rm ngrok-stable-linux-arm.zip && \
    sleep 5

# Dar permisos de ejecución al binario de ngrok
RUN echo "Paso 3: Dando permisos de ejecución a Ngrok..." && \
    chmod +x /config/ngrok && \
    sleep 5

# Agregar /config al PATH directamente
RUN echo "Paso 4: Agregando /config al PATH..." && \
    echo 'export PATH=$PATH:/config' >> /etc/profile && \
    sleep 2

# Activar el Authtoken de Ngrok
RUN echo "Paso 5: Activando el Authtoken..." && \
    /config/ngrok config add-authtoken 2rN3m0LjxhvMDXBRLMfRp49jIZV_UGMfFienJ1zphunmu87D && \
    sleep 5

# Cerrar cualquier sesión previa de Ngrok
RUN echo "Paso 6: Cerrando sesiones previas de Ngrok..." && \
    pkill -f ngrok && \
    sleep 5

# Ejecutar Ngrok para exponer Home Assistant en el puerto 8123
CMD echo "Paso 7: Ejecutando Ngrok..." && \
    /config/ngrok http --url=live-firmly-jackal.ngrok-free.app 8123

