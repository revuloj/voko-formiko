#!/bin/bash
# set -x

echo "### Prepari tempotaskojn (cron)..."

# debug
ls -l /config/*

cronfile=/config/voko-formiko.agordo-cron

#chmod 0644 ${cronfile}
crontab ${cronfile}

