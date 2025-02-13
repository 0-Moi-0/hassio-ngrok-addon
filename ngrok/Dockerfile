ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8


# Usamos una imagen base oficial de Ubuntu compatible con ARM
FROM arm64v8/ubuntu:20.04

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    curl \
    bash

# Descargar e instalar Ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip && \
    unzip ngrok-stable-linux-arm.zip && \
    rm ngrok-stable-linux-arm.zip && \
    mv ngrok /usr/local/bin/

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
