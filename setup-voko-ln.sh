#!/bin/bash

echo "Kreas la dosierstrukturon de VOKO el Voko-Iloj per la novaj strukturoj de voko-grundo kaj voko-formiko el Git."
echo "Kelkiaj malmultaj skriptoj provizore ankoraŭ uziĝas el la malnova voko-svn (mirror.pl, processmail.pl)."
echo ""

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

#vd. malsupre: ln -s ${HOME}/voko-grundo/bin $VOKO/bin
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

# kunmetu /bin/ el pluraj strukturoj: voko-grundo, voko-formiko, voko-svn
mkdir $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/alinomu.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/bedic_purigo.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/cfg2html.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/dictfaru.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/doklingv.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/dtd2html.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/dtd.pm $VOKO/bin/
#ln -s ${HOME}/voko-grundo/bin/esignoj.pl $VOKO/bin/
#ln -s ${HOME}/voko-grundo/bin/forigu.pl $VOKO/bin/
#ln -s ${HOME}/voko-grundo/bin/historio.pl $VOKO/bin/
#ln -s ${HOME}/voko-grundo/bin/htmlposte.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/insert-art-blobs.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/insert-txt-blobs.pl $VOKO/bin/
#ln -s ${HOME}/voko-grundo/bin/lat3_utf8.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/spegulo_tar.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/tushu.pl $VOKO/bin/
ln -s ${HOME}/voko-grundo/bin/xdxf_belformat.pl $VOKO/bin/

ln -s ${HOME}/voko-formiko/bin/insert-art-blobs.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/gitlogxml2w.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/gitlogxml.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/gitlogart.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/jing2xml.sh $VOKO/bin/
ln -s ${HOME}/voko-formiko/bin/jing2html.sh $VOKO/bin/

ln -s ${HOME}/voko-svn/bin/mirror.pl $VOKO/bin/
ln -s ${HOME}/voko-svn/bin/redaktoservo.pl $VOKO/bin/
ln -s ${HOME}/voko-svn/bin/processmail.pl $VOKO/bin/
