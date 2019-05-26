#!/bin/bash
set -x

if [ ! -e /home/formiko/revo/index.html ]; then
    echo "AVERTO: La medio en revo/ estas ankoraŭ ne kreita."
    echo "  Aŭ provizu aktualan vortaron kun ĉiuj dosieroj en revo/"
    echo "  Aŭ kreu novan vortaran kadron per komando 'formiko med-medio'"
    echo "  Ekz.: 'docker exec ${formiko_id} formiko med-medio'."
fi

if [ ! -e /home/formiko/revo/cfg/agordo ]; then
    mkdir -p /home/formiko/revo/cfg
    cp /etc/revo.cfg /home/formiko/revo/cfg/agordo
fi

if [ ! -e /home/formiko/revo/dtd ]; then
    cp -r /home/formiko/voko/dtd /home/formiko/revo/dtd
fi