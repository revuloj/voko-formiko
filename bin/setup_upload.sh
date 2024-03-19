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
  CGI_SERVER=$(cat ${SECRETS}/voko-araneo.cgi_server)
fi

if [[ -z "$CGI_USER" ]]; then
  CGI_USER=$(cat ${SECRETS}/voko-araneo.cgi_user)
fi

if [[ -z "$CGI_PASSWD" ]]; then
  CGI_PASSWD=$(cat ${SECRETS}/voko-araneo.cgi_password)
fi

### por la transiro al nova servilo ni subtenas
# duan agordon...

if [[ -z "$FTP_SERVER2" ]]; then
  FTP_SERVER2=$(cat ${SECRETS}/voko-sesio.ftp_server2)
fi

if [[ -z "$FTP_USER2" ]]; then
  FTP_USER2=$(cat ${SECRETS}/voko-sesio.ftp_user2)
fi

if [[ -z "$FTP_PASSWD2" ]]; then
  FTP_PASSWD2=$(cat ${SECRETS}/voko-sesio.ftp_password2)
fi

if [[ -z "$CGI_SERVER2" ]]; then
  CGI_SERVER2=$(cat ${SECRETS}/voko-araneo.cgi_server2)
fi

if [[ -z "$CGI_USER2" ]]; then
  CGI_USER2=$(cat ${SECRETS}/voko-araneo.cgi_user2)
fi

if [[ -z "$CGI_PASSWD2" ]]; then
  CGI_PASSWD2=$(cat ${SECRETS}/voko-araneo.cgi_password2)
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

servilo2.dir=${FTP_DIR}
servilo2.host=${FTP_SERVER2}
servilo2.user=${FTP_USER2}
servilo2.password=${FTP_PASSWD2}

tempo.url=http://${CGI_SERVER}/cgi-bin/admin/time.pl

upload.url=http://${CGI_SERVER}/cgi-bin/admin/uprevo.pl?fname=
upload.user=${CGI_USER}
upload.password=${CGI_PASSWD}

upload2.url=https://${CGI_SERVER2}/cgi-bin/admin/uprevo.pl?fname=
upload2.user=${CGI_USER2}
upload2.password=${CGI_PASSWD2}

vikio.url=http://${CGI_SERVER}/cgi-bin/admin/upviki.pl?download=0
vikio.user=${CGI_USER}
vikio.password=${CGI_PASSWD}

vikio2.url=https://${CGI_SERVER2}/cgi-bin/admin/upviki.pl?download=0
vikio2.user=${CGI_USER2}
vikio2.password=${CGI_PASSWD2}

EOT

else
  echo "AVERTO: ${spegulo_agordo} mankas."
fi