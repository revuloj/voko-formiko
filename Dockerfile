FROM openjdk:jre-slim
MAINTAINER <diestel@steloj.de>

RUN apt-get update && apt-get install -y --no-install-recommends \
    cron curl unzip ant libxalan2-java libsaxonhe-java \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash -u 1001 formiko
WORKDIR /home/formiko

#RUN mkdir /home/revo/voko && ln -s /home/revo/revo/dtd /home/revo/voko/dtd

RUN curl -LO https://github.com/revuloj/voko-grundo/archive/master.zip \
  && unzip master.zip voko-grundo-master/xsl/* voko-grundo-master/dtd/* voko-grundo-master/cfg/* \
     voko-grundo-master/owl/voko.rdf \
  && ln -s voko-grundo-master voko && rm master.zip 

USER formiko:users

#ant -f /home/revo/voko/ant/medio.xml med-cfg

# FARENDA:
# uzu ant-regulon por krei respiro.jar...?
# prenu xml el revo - verŝajne plej bone dum lanĉo de la procesumo, por
# havi ĝin sur ekstera dosierujo kaj ne forĵeti la ŝanĝojn...
# kreu bazan vortaron el ĉio ĉi (medio, tuto...)
# pripensu kiel speguli la dosierojn al la http-servo
# eblecoj: kiel nuntempe per ftp, alternative per rsync, cvs, git (aŭ eĉ komuna dosierujo?)




