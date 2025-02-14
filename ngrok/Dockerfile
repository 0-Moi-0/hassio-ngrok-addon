ARG BUILD_FROM
FROM $BUILD_FROM

# Actualizar el contenedor y luego instalar las herramientas necesarias
RUN apk add --no-cache sshpass sudo curl wget jq bash

# Cambia a un usuario con privilegios adecuados para tu complemento
USER root

# Si necesitas otros pasos para la configuración de tu complemento, añádelos aquí

# Comando predeterminado para ejecutar cuando se inicie el contenedor
CMD ["/bin/bash"]



# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]
