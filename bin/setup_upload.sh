#!/bin/bash
set -x

# https://docs.docker.com/v17.09/engine/swarm/networking/
# https://neuvector.com/network-security/docker-swarm-container-networking/
# https://docs.docker.com/compose/compose-file/#networks
#
# la servo-nomo por aliri Sesion tra "docker swarm ingress" ... ne funkcias de interne ŝajne,
# sed funkcias al gw_bridge:
FTP_SERVER=sesio
FTP_USER=sesio

if [ -e /run/secrets/voko-sesio.ftp_password ]; then
  FTP_PASSWD=$(cat /run/secrets/voko-sesio.ftp_password)
else
  #ls /secrets/*
  FTP_PASSWD=$(cat /secrets/voko-sesio/ftp_password)
fi  

CGI_USER=araneo
if [ -e /run/secrets/voko-araneo.cgi_password ]; then
  CGI_PASSWD=$(cat /run/secrets/voko-araneo.cgi_password)
else
  CGI_PASSWD=$(cat /secrets/voko-araneo/cgi_password)
fi  

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

fi