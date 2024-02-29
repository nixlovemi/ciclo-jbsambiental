#!/usr/bin/env bash

ENV_FILE=/git/config/vagrant/env

docker run -d \
  -p 8000:8000 \
  -v /git/frontend:/usr/src/frontend \
  --name frontend \
  --env-file ${ENV_FILE} \
  local/frontend:1.0.0.0
