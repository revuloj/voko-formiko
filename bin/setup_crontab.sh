#!/bin/bash
set -x

cronfile=/voko-formiko.agordo-cron

#chmod 0644 ${cronfile}
crontab ${cronfile}

