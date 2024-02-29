#!/usr/bin/env bash

# flags
set -o errexit # make your script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
set -o nounset # exit when your script tries to use undeclared variables
set -o xtrace # print all commands executed

# Python
apt-get install -y python3 python3-pip

# uWSGI and MySQL
apt-get update && \
    apt-get install -y python3-dev default-libmysqlclient-dev build-essential \
    uwsgi uwsgi-plugin-python3

# pip and requirements
pip3 install --upgrade pip
python3 -m pip install -r requirements.txt
