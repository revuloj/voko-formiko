#!/bin/bash

# provizas kelkajn komandojn utilajn por prepari specifajn eldonojn
# de voko-formiko
#
# jen kelkaj informoj kiel eviti plurfoje doni la pasvorton por scp:
# https://linux.101hacks.com/unix/ssh-controlmaster/
# + ControlPersist 2m
# http://blogs.perl.org/users/smylers/2011/08/ssh-productivity-tips.html

# aldonu en /etc/hosts!
#host=retavortaro.de

# Tio estas la eldono de voko-grundo kontraŭ kiu ni kompilas ĉion
# ĝi devas ekzisti jam kiel git-tag (kaj sekve kiel kodarĥivo kaj procezujo) en Github
# en celo "preparo" ni metas tiun eldonon ankaŭ por dosiernomoj kc. de voko-araneo
# Ni ankaŭ supozas, ke nova eldono okazas en git-branĉo kun la sama nomo
# Ĉe publikigo marku la kodstaton per etikedo (git-tag) v${eldono}.
# Dum la realigo vi povas ŝovi la etikedon ĉiam per celo "etikedo".
eldono=2h

# ni komprenas preparo | etikedo | helpo
target="${1:-helpo}"

case $target in
preparo)
    # kontrolu ĉu la branĉo kongruas kun la agordita versio
    branch=$(git symbolic-ref --short HEAD)
    if [ "${branch}" != "${eldono}" ]; then
        echo "Ne kongruas la branĉo (${branch}) kun la eldono (${eldono})"
        echo "Agordu la variablon 'eldono' en tiu ĉi skripto por prepari novan eldonon."
        exit 1
    fi

    #echo "Aktualigante skriptojn al nova eldono ${eldono}..."
    #sed -ri 's/ARG VG_BRANCH=.*?$/ARG VG_BRANCH='${eldono}'/' Dockerfile
    ;;
kreo)
    echo "Kreante lokan procezujon (por docker) voko-formiko kiel eldono ${eldono}"
    docker pull ghcr.io/revuloj/voko-grundo/voko-formiko:${eldono}
    docker build --build-arg VG_TAG=v${eldono} --build-arg ZIP_SUFFIX=${eldono} -t voko-formiko .
    ;;
etikedo)
    echo "Provizante la aktualan staton per etikedo (git tag) v${eldono}"
    echo "kaj puŝante tiun staton al la centra deponejo"
    git tag -f v${eldono} && git push && git push --tags -f
    ;;
helpo | *)
    echo "---------------------------------------------------------------------------"
    echo "Tiu skripto servas por prepari kaj eldoni procezujon voko-formiko."
    echo "Tiucele ekzistas celoj 'preparo', 'etikedo'."
    echo ""
    echo "Per la aparta celo 'preparo' oni povas krei git-branĉon kun nova eldono por tie "
    echo "komenci programadon de novaj funkcioj, ŝanĝoj ktp. Antaŭe adaptu en la kapo de ĉi-skripto"
    echo "la variablon 'eldono'."
    echo "Per la celo 'etikedo' vi provizas aktualan staton per 'git tag', necesa por "
    echo "ke kompiliĝu ĉe Github nova eldono de procezujo voko-formiko kiel bazo por la redaktoservo."
    ;;    
esac
