#!/bin/bash
#set -x

setup_crontab.sh

if [ ! -e revo/index.html ]; then
    echo "AVERTO: La medio en revo/ estas ankoraŭ ne kreita."
    echo "  Aŭ provizu aktualan vortaron kun ĉiuj dosieroj en revo/"
    echo "  Aŭ kreu novan vortaran kadron per komando 'formiko med-medio'"
    echo "  Ekz.: 'docker exec ${formiko_id} formiko med-medio'."
fi

exec "$@"