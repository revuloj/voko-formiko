#!/bin/bash
set -x

# debug
ls -l /config/*

cfgfile=/config/voko-formiko.agordo-redaktoservo

ln -s ${cfgfile} /home/formiko/etc/redaktoservo-agordo