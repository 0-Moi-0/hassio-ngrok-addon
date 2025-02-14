#ARG BUILD_FROM
#FROM $BUILD_FROM

# Utilizar una imagen base compatible con ARM para Raspberry Pi
FROM debian:latest

# Actualizar los repositorios e instalar las herramientas necesarias
RUN apt-get update && \
    apt-get install -y sshpass && \
    apt-get clean

# Comando por defecto al iniciar el contenedor
CMD ["bash"]


# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]
