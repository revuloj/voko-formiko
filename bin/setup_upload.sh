#!/bin/bash
set -x

# https://stackoverflow.com/questions/36054419/eot-in-conditional-section-of-bash-script

# la servo-nomo por aliri Sesion tra "docker swarm ingress"
FTP_SERVER=172.20.0.1
FTP_USER=sesio
FTP_PASSWD=$(cat /run/secrets/voko-sesio.ftp_password)

CGI_USER=araneo
CGI_PASSWD=$(cat /run/secrets/voko-araneo.cgi_password)

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