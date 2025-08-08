#!/bin/bash
# set -x

echo "### Prepari tempotaskojn (cron)..."

# debug
ls -l /config/*

# kreata per `docker config create ...` ĉe docker swarm 
# vd. revo-medioj/formikujo-s/bin/voko-agordo-cron-*
cronfile=/config/voko-formiko.agordo-cron

#chmod 0644 ${cronfile}
crontab ${cronfile}

