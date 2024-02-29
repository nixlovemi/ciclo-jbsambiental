#!/usr/bin/env bash

# Apply salt state o localhost

# flags
set -o errexit # make your script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
set -o nounset # exit when your script tries to use undeclared variables
set -o xtrace # print all commands executed

salt-call test.ping || true
sleep 2

salt-call test.ping || true
sleep 2

salt-call test.ping
salt-call state.apply
