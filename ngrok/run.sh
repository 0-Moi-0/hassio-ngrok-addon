#!/bin/bash

AUTHTOKEN=$(bashio::config 'authtoken')

if [[ -z "$AUTHTOKEN" ]]; then
  echo "ERROR: No authtoken provided!"
  exit 1
fi

ngrok config add-authtoken "$AUTHTOKEN"
ngrok http 8123
