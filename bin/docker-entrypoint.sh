#!/bin/bash
#set -x

setup_revo.sh
setup_upload.sh
setup_crontab.sh

exec "$@"