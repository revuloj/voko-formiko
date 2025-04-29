#!/bin/bash

# tuj finu se unuopa komando fiaskas 
# - necesas por distingi sukcesan de malsukcesa testaro
set -e
#set -x

docker_image="${1:-voko-formiko:latest}"

docker run --rm --name formiko-test --entrypoint '' ${docker_image} bash -c "ls -l /usr/local/bin && bash -n /usr/local/bin/*.sh"

# lanĉi la test-procezujon
docker run --rm --name formiko-test --rm -d ${docker_image}

echo ""; echo "Ni petas helpon..."
docker exec formiko-test formiko art-helpo

echo ""; echo "Ni rigardas dosierujon..."
docker exec formiko-test bash -c 'ls /apache-*'

echo ""; echo "Ni rigardas ant-dosierujon..."
docker exec formiko-test bash -c 'pwd && ls ./voko/ant'

echo ""; echo "Ni lanĉas testaron..."
docker exec formiko-test bash -c 'ant -f ./voko/ant/au-testoj.xml'

echo ""; echo "Forigi..."
docker kill formiko-test