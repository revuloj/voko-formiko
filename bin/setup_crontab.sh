#!/bin/bash
set -x

ls -l /*formiko*
cat /formiko-agordo-cron

if [ -e /voko-formiko.agordo-cron ]; then
  cronfile=/voko-formiko.agordo-cron
else
  cronfile=/formiko-agordo-cron/voko-formiko.agordo-cron
fi  

#chmod 0644 ${cronfile}
crontab ${cronfile}

