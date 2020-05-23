#!/bin/bash
# set -x

echo "### Prepari Revon..."

basedir=/home/formiko

if [ ! -e $basedir/revo/index.html ]; then
    echo "AVERTO: La medio en revo/ estas ankoraŭ ne kreita."
    echo "  Aŭ provizu aktualan vortaron kun ĉiuj dosieroj en revo/"
    echo "  Aŭ kreu novan vortaran kadron per komando 'formiko med-medio'"
    echo "  Ekz.: 'docker exec ${formiko_id} formiko med-medio'."
fi

if [ ! -e $basedir/revo/cfg/agordo ]; then
    mkdir -p $basedir/revo/cfg
    cp /etc/agordo $basedir/revo/cfg/agordo
fi

if [ ! -e $basedir/revo/dtd ]; then
    cp -r $basedir/voko/dtd $basedir/revo/dtd
fi

if [ ! -e $basedir/tgz ]; then
    mkdir -p $basedir/tgz
    chown formiko.users $basedir/tgz    
fi

if [[ ! $(ls -A /home/formiko/revo-fonto) ]]; then
    # vi povas antaŭdifini ekz.:
    # GIT_REPO_REVO=https://github.com/revuloj/revo-fonto-testo.git
    # por preni la fontojn el Git-arĥivo
    if [[ ! -z "$GIT_REPO_REVO" ]]; then
        #?? git clone --progress $GIT_REPO_REVO revo-fonto
        cd $basedir
        git clone $GIT_REPO_REVO revo-fonto
        chown -R formiko:formiko revo-fonto
        mkdir -p $basedir/revo/xml
        mkdir -p $basedir/revo/bld
        cp $basedir/revo-fonto/revo/*.xml $basedir/revo/xml/
        cp $basedir/revo-fonto/bld/* $basedir/revo/bld/
        cp $basedir/revo-fonto/cfg/*.xml $basedir/revo/cfg/
    fi
fi

chown formiko:formiko $basedir/revo/cfg
chown -R formiko:formiko $basedir/revo/dtd
chown -R formiko:formiko $basedir/revo/bld
chown -R formiko:formiko $basedir/revo/xml
