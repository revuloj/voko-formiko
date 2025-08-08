#!/bin/bash
#set -x

echo "### Prepari redaktoservon..."

export CLASSPATH=$SAXONJAR:$JINGJAR

# debug
ls -l /config/*

# kreata per `docker config create ...` ĉe docker swarm 
# vd. revo-medioj/formikujo-s/bin/voko-agordo-redaktoservo-*
cfgfile=/config/voko-formiko.agordo-redaktoservo

ln -s ${cfgfile} /home/formiko/etc/redaktoservo-agordo