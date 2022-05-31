#!/bin/bash

# provizas kelkajn komandojn utilajn por prepari specifajn eldonojn
# de voko-formiko
#
# jen kelkaj informoj kiel eviti plurfoje doni la pasvorton por scp:
# https://linux.101hacks.com/unix/ssh-controlmaster/
# + ControlPersist 2m
# http://blogs.perl.org/users/smylers/2011/08/ssh-productivity-tips.html

#host=retavortaro.de
# aldonu en /etc/hosts!
release=2f

# ni komprenas preparo | etikedo | helpo
target="${1:-helpo}"

case $target in
preparo)
    # kontrolu ĉu la branĉo kongruas kun la agordita versio
    branch=$(git symbolic-ref --short HEAD)
    if [ "${branch}" != "${release}" ]; then
        echo "Ne kongruas la branĉo (${branch}) kun la eldono (${release})"
        echo "Agordu la variablon 'release' en tiu ĉi skripto por prepari novan eldonon."
        exit 1
    fi

    echo "Aktualigante skriptojn al nova eldono ${release}..."
    sed -ri 's/ARG VG_BRANCH=.*?$/ARG VG_BRANCH='${release}'/' Dockerfile
    ;;
kreo)
    echo "Kreante lokan procezujon (por docker) voko-formiko"
    docker pull ghcr.io/revuloj/voko-grundo/voko-formiko:${release}
    docker build -t voko-formiko .
    ;;
etikedo)
    echo "Provizante la aktualan staton per etikedo (git tag) v${release}"
    echo "kaj puŝante tiun staton al la centra deponejo"
    git tag -f v${release} && git push && git push --tags -f
    ;;
helpo | *)
    echo "---------------------------------------------------------------------------"
    echo "Tiu skripto servas por prepari kaj eldoni procezujon voko-formiko."
    echo "Tiucele ekzistas celoj 'preparo', 'etikedo'."
    echo ""
    echo "Per la aparta celo 'preparo' oni povas krei git-branĉon kun nova eldono por tie "
    echo "komenci programadon de novaj funkcioj, ŝanĝoj ktp. Antaŭe adaptu en la kapo de ĉi-skripto"
    echo "la variablon 'release'."
    echo "Per la celo 'etikedo' vi provizas aktualan staton per 'git tag', necesa por "
    echo "ke kompiliĝu ĉe Github nova eldono de procezujo voko-formiko kiel bazo por la redaktoservo."
    ;;    
esac
