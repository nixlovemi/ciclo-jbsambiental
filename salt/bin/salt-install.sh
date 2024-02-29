#!/usr/bin/env bash

# Install Salt

# flags
set -o errexit # make your script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
set -o nounset # exit when your script tries to use undeclared variables
set -o xtrace # print all commands executed

# constants
VERSION="3000.5"
MASTER=$(hostname -s)

# dependencies
apt-get install -y wget

# saltstack install
bootstrap_script=/tmp/bootstrap-salt.sh
rm -f ${bootstrap_script}
wget -O ${bootstrap_script} https://bootstrap.saltstack.com
sudo sh ${bootstrap_script} -M stable ${VERSION}
rm -f ${bootstrap_script}

# enable and restart services
systemctl enable salt-master
systemctl enable salt-minion
systemctl restart salt-master
systemctl restart salt-minion
