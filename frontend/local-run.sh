#!/usr/bin/env bash

# flags
set -o errexit # make your script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
set -o nounset # exit when your script tries to use undeclared variables
set -o xtrace # print all commands executed

export $(cat /git/config/vagrant/env | xargs)

python3 manage.py runserver 0:8000
#uwsgi --plugins http,python3,logfile --http :8000 --module root.wsgi --processes 2 --threads 2
