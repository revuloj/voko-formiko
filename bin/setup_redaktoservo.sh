#!/bin/bash
#set -x

echo "### Prepari redaktoservon..."

export CLASSPATH=$SAXONJAR:$JINGJAR

# debug
ls -l /config/*

cfgfile=/config/voko-formiko.agordo-redaktoservo

ln -s ${cfgfile} /home/formiko/etc/redaktoservo-agordo