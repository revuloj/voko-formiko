#!/bin/bash
# set -x

echo "### Prepari alŝuton (ftp ktp.)..."

# https://docs.docker.com/v17.09/engine/swarm/networking/
# https://neuvector.com/network-security/docker-swarm-container-networking/
# https://docs.docker.com/compose/compose-file/#networks
#
# la servo-nomo por aliri Sesion tra "docker swarm ingress" ... ne funkcias de interne ŝajne,
# sed funkcias al gw_bridge:
FTP_SERVER=sesio
FTP_USER=sesio

# debug
ls -l ${SECRETS}/*

FTP_PASSWD=$(cat ${SECRETS}/voko-sesio.ftp_password)

CGI_USER=araneo
CGI_PASSWD=$(cat ${SECRETS}/voko-araneo.cgi_password)

# debug
ls -l /home/formiko/etc/*agordo*

spegulo_agordo=/home/formiko/etc/spegulo-agordo-revo

if [ ! -e ${spegulo_agordo} ]; then
  cp /etc/spegulo-agordo-revo ${spegulo_agordo}

  cat >> ${spegulo_agordo} <<EOT
servilo.host=${FTP_SERVER}
servilo.user=${FTP_USER}
servilo.password=${FTP_PASSWD}

upload.user=${CGI_USER}
upload.password=${CGI_PASSWD}
redaktantoj.user=${CGI_USER}
redaktantoj.password=${CGI_PASSWD}
versioj.user=${CGI_USER}
versioj.password=${CGI_PASSWD}
vikio.user=${CGI_USER}
vikio.password=${CGI_PASSWD}
resendo.user=${CGI_USER}
resendo.password=${CGI_PASSWD}
EOT

else
  echo "AVERTO: ${spegulo_agordo} mankas."
fi