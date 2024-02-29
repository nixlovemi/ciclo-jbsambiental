#!/usr/bin/env bash

# Add the localserver at its own master

# flags
set -o errexit # make your script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
set -o nounset # exit when your script tries to use undeclared variables
set -o xtrace # print all commands executed

MASTER=$(hostname -s)
grep "master: ${MASTER}" /etc/salt/minion || echo "master: ${MASTER}" >> /etc/salt/minion

systemctl restart salt-master
systemctl restart salt-minion
sleep 5
systemctl restart salt-minion
sleep 10
salt-key --accept=${MASTER} --yes
