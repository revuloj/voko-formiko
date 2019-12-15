#!/bin/sh

# la servo-nomo por aliri Sesion tra "docker swarm ingress"
FTP_SERVER=localhost
FTP_USER=sesio
FTP_PASSWD=$(cat /run/secrets/voko-sesio.ftp_password)

CGI_USER=araneo
CGI_PASSWD=$(cat /run/secrets/voko-araneo.cgi_password)

spegulo-agordo=/home/formiko/etc/spegulo-agordo-revo

if [ ! -e ${spegulo-agordo} ]; then
  cp /etc/spegulo-agordo-revo ${spegulo-agordo}

  cat <<EOT > ${spegulo-agordo}
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