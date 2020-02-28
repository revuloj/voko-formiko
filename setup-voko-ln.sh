#!/bin/bash

if [[ -z $VOKO || ! -d "$VOKO" ]]; then
    echo "Vi devas unue krei voko-dosierujon kaj difini variablon, ekzemple tiel:"
    echo "  mkdir ~/voko"
    echo "# add in ~/.bashrc"
    echo "  export VOKO=/home/revo/voko"
    echo ""
    exit 1 
fi

if [[ "$(ls -A $VOKO)" ]]; then 
    echo "Dosierujo $VOKO ne estas malplena. Por ne damaĝi ĝin, nenio kreiĝas ene!"
    exit 1
fi    

if [[ ! -d "${HOME}/voko-grundo" ]]; then 
    echo "Dosierujo voko-grundo mankas. Elŝutu ĝin de Git!"
fi    

if [[ ! -d "${HOME}/voko-formiko" ]]; then 
    echo "Dosierujo voko-formiko mankas. Elŝutu ĝin de Git!"
fi    

ln -s ${HOME}/voko-grundo/bin $VOKO/bin
ln -s ${HOME}/voko-grundo/cfg $VOKO/cfg
ln -s ${HOME}/voko-grundo/dok $VOKO/dok
ln -s ${HOME}/voko-grundo/dtd $VOKO/dtd
ln -s ${HOME}/voko-grundo/owl $VOKO/owl
ln -s ${HOME}/voko-grundo/smb $VOKO/smb
ln -s ${HOME}/voko-grundo/jsc $VOKO/jsc
ln -s ${HOME}/voko-grundo/sql $VOKO/sql
ln -s ${HOME}/voko-grundo/stl $VOKO/stl
ln -s ${HOME}/voko-grundo/xsl $VOKO/xsl

ln -s ${HOME}/voko-formiko/ant $VOKO/ant
ln -s ${HOME}/voko-formiko/jav $VOKO/jav

ln -s ${HOME}/voko-formiko/bin/insert-art-blobs.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/gitlogxml2w.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/gitlogxml.sh $VOKO/bin/