ARG BUILD_FROM
FROM $BUILD_FROM

FROM homeassistant/aarch64-base:latest
# Instalar git y otras dependencias necesarias
RUN apt-get update && apt-get install -y git
# Instalar Home Assistant CLI (ha)
RUN curl -sSL https://get.home-assistant.io | bash


# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]
