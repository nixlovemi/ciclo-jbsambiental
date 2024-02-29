#!/usr/bin/env bash

docker stop frontend
docker rm frontend
docker rmi "local/frontend:1.0.0.0" --force
docker build --tag=local/frontend:1.0.0.0 ./

salt-call state.sls frontend
