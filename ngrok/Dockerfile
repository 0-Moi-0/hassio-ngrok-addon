ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

FROM homeassistant/amd64-base:latest

RUN apk add --no-cache bash curl unzip

RUN curl -fsSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip -o /tmp/ngrok.zip \
    && unzip /tmp/ngrok.zip -d /usr/local/bin \
    && rm /tmp/ngrok.zip

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
