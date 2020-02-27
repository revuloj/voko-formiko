FROM openjdk:jre-slim
LABEL Author=<diestel@steloj.de>

# libcommons-net-java, liboro-java required for ant ftp task
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip cron ssh libjsch-java libcommons-net-java liboro-java ant ant-optional \
    libxalan2-java libsaxonb-java libsaxonhe-java sqlite3 bsdmainutils \
	&& rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/share/java/commons-net.jar /usr/share/ant/lib/commons-net.jar \
  && ln -s /usr/share/java/oro.jar /usr/share/ant/lib/oro.jar
#   openssh-server 	&& mkdir -p /var/run/sshd 

COPY bin/* /usr/local/bin/

RUN useradd -ms /bin/bash -u 1001 formiko
WORKDIR /home/formiko
ENV REVO /home/formiko/revo
ENV VOKO /home/formiko/voko
# problemo kun normlaizeDAta.xml en Saxon-HE!
#ENV SAXONJAR /usr/share/java/Saxon-HE.jar
ENV SAXONJAR /usr/share/java/saxonb.jar
ENV ANT_OPTS=-Xmx1000m

#RUN mkdir /home/revo/voko && ln -s /home/revo/revo/dtd /home/revo/voko/dtd

RUN curl -LO https://github.com/revuloj/voko-grundo/archive/master.zip \
  && unzip master.zip voko-grundo-master/xsl/* voko-grundo-master/dtd/* voko-grundo-master/cfg/* \
     voko-grundo-master/sql/* voko-grundo-master/owl/voko.rdf \
  && ln -s voko-grundo-master voko && rm master.zip \
  && chown formiko ${VOKO}/xsl/revo_tez.xsl ${VOKO}/xsl/revohtml2.xsl ${VOKO}/xsl/revohtml.xsl \
  && mkdir -p revo && mkdir -p tmp/inx_tmp && mkdir -p log && chown -R formiko:users revo tmp log 

#USER formiko:users
COPY ant ${VOKO}/ant
# ni poste kopios tion al ${REVO}/cfg
# ĉar ${REVO} estos injektita nur ĉe lanĉo de Formiko
COPY cfg/* /etc/

# FARENDA:
# uzu ant-regulon por krei respiro.jar...?
# prenu xml el revo - verŝajne plej bone dum lanĉo de la procesumo, por
# havi ĝin sur ekstera dosierujo kaj ne forĵeti la ŝanĝojn...
# kreu bazan vortaron el ĉio ĉi (medio, tuto...)
# pripensu kiel speguli la dosierojn al la http-servo
# eblecoj: kiel nuntempe per ftp, alternative per rsync, cvs, git (aŭ eĉ komuna dosierujo?)

## https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container
RUN touch /var/log/cron.log

HEALTHCHECK --interval=5m --timeout=3s CMD health_check_cron.sh 

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron","-f"]
