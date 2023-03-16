#!/bin/bash

# deplojas iujn dosierojn, precipe por subteni pli rapidan teston post 
# kodŝanĝoj
#

# ni komprenas  helpo| docker | docker-ant kaj supozas "helpo", se nenio donita argumente
target="${1:-helpo}"

ANT=ant/*.xml
antdir=/home/formiko/voko/ant

case $target in
docker)
   # aldonebla ... nun ni tuj transiras al la sekva...
   ;;&
docker-ant)
    formiko_id=$(docker ps --filter name=formikujo_formiko -q)
    echo "kopiante ANT-dosierojn al ${formiko_id}:${antdir}..."
    for file in ${ANT}; do
        echo ${file}
        docker cp ${file} ${formiko_id}:${antdir}
    done
    ;;        
*)    
    echo "Nevalida celo, enrigaru ĉi-skripton por vidi la eblajn celojn, ekz-e docker-ant)"    
    ;;&
helpo|*)
    echo "---------------------------------------------------------------------------"
    echo "Tiu ĉi skripto servas por sendi loke preparitajn dosierojn"
    echo "en la docker-procezujojn, por elprovi kaj sencimigi ilin tie."
    echo ""
    echo "(Por fina publikgo al la servilo uzu la skripton eldono.sh)"
    ;;
esac
