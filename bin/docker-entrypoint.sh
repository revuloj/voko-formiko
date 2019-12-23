#!/bin/bash
#set -x

# workaround for docker stack vs. kubernetes incompatibility
if [ -e /secrets/ ]; then
  # kubernetes
  export SECRETS=/secrets
else
  # docker stack
  export SECRETS=/run/secrets
fi    

setup_revo.sh
setup_upload.sh
setup_crontab.sh

exec "$@"