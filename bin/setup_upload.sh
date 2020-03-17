#!/bin/bash
# set -x

echo "### Prepari alŝuton (ftp ktp.)..."

# https://docs.docker.com/v17.09/engine/swarm/networking/
# https://neuvector.com/network-security/docker-swarm-container-networking/
# https://docs.docker.com/compose/compose-file/#networks
#
# la servo-nomo por aliri Sesion tra "docker swarm ingress" ... ne funkcias de interne ŝajne,
# sed funkcias al gw_bridge:
#FTP_SERVER=sesio
#FTP_USER=sesio

# debug
ls -l ${SECRETS}/*

if [[ -z "$FTP_SERVER" ]]; then
  FTP_SERVER=$(cat ${SECRETS}/voko-sesio.ftp_server)
  FTP_DIR=./alveno
else
  FTP_DIR=.  
fi

if [[ -z "$FTP_USER" ]]; then
  FTP_USER=$(cat ${SECRETS}/voko-sesio.ftp_user)
fi

if [[ -z "$FTP_PASSWD" ]]; then
  FTP_PASSWD=$(cat ${SECRETS}/voko-sesio.ftp_password)
fi

#CGI_USER=araneo

if [[ -z "$CGI_SERVER" ]]; then
  CGI_SERVER=$(cat ${SECRETS}/voko-sesio.cgi_server)
fi

if [[ -z "$CGI_USER" ]]; then
  CGI_USER=$(cat ${SECRETS}/voko-sesio.cgi_user)
fi

if [[ -z "$CGI_PASSWD" ]]; then
  CGI_PASSWD=$(cat ${SECRETS}/voko-sesio.cgi_password)
fi

# debug
ls -l /home/formiko/etc/*agordo*

spegulo_agordo=/home/formiko/etc/spegulo-agordo-revo

if [ ! -e ${spegulo_agordo} ]; then
  cp /etc/spegulo-agordo-revo ${spegulo_agordo}

  cat >> ${spegulo_agordo} <<EOT
servilo.dir=${FTP_DIR}
servilo.host=${FTP_SERVER}
servilo.user=${FTP_USER}
servilo.password=${FTP_PASSWD}

tempo.url=http://${CGI_SERVER}/cgi-bin/admin/time.pl
upload.url=http://${CGI_SERVER}/cgi-bin/admin/uprevo.pl?fname=
upload.user=${CGI_USER}
upload.password=${CGI_PASSWD}

vikio.url=http://${CGI_SERVER}/cgi-bin/admin/upviki.pl?download=0
vikio.user=${CGI_USER}
vikio.password=${CGI_PASSWD}
EOT

else
  echo "AVERTO: ${spegulo_agordo} mankas."
fi