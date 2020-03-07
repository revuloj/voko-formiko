#!/bin/bash
# set -x

echo "### Prepari Revon..."

if [ ! -e /home/formiko/revo/index.html ]; then
    echo "AVERTO: La medio en revo/ estas ankoraŭ ne kreita."
    echo "  Aŭ provizu aktualan vortaron kun ĉiuj dosieroj en revo/"
    echo "  Aŭ kreu novan vortaran kadron per komando 'formiko med-medio'"
    echo "  Ekz.: 'docker exec ${formiko_id} formiko med-medio'."
fi

if [ ! -e /home/formiko/revo/cfg/agordo ]; then
    mkdir -p /home/formiko/revo/cfg
    cp /etc/agordo /home/formiko/revo/cfg/agordo
fi

if [ ! -e /home/formiko/revo/dtd ]; then
    cp -r /home/formiko/voko/dtd /home/formiko/revo/dtd
fi

if [ ! -e /home/formiko/tgz ]; then
    mkdir -p /home/formiko/tgz
    chown formiko.users /home/formiko/tgz    
fi

chown formiko:formiko /home/formiko/revo/cfg
chown -R formiko:formiko /home/formiko/revo/dtd

if [[ ! $(ls -A /home/formiko/revo-fonto) ]]; then
    # vi povas antaŭdifini ekz.:
    # GIT_REPO_REVO=https://github.com/revuloj/revo-fonto-testo.git
    # por preni la fontojn el Git-arĥivo
    if [[ ! -z "$GIT_REPO_REVO" ]]; then
        #?? git clone --progress $GIT_REPO_REVO revo-fonto
        git clone $GIT_REPO_REVO revo-fonto
    fi
fi
