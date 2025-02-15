#ARG BUILD_FROM
#FROM $BUILD_FROM

# Usa Alpine, que es más liviano y compatible con Home Assistant
FROM alpine:latest

# Instala herramientas necesarias
RUN apk update && apk add --no-cache openssh sshpass

# Comando por defecto al iniciar el contenedor
#CMD ["sh"]



# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]
