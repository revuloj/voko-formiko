FROM openjdk:jre-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip ant libxalan2-java libsaxonhe-java \
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




