#!/bin/bash
set -x

# debug
ls -l /config/*

cronfile=/config/voko-formiko.agordo-cron

#chmod 0644 ${cronfile}
crontab ${cronfile}

