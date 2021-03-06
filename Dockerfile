#######################################################
# staĝo 1: Ni bezonas TeX kaj metapost por konverti simbolojn al png
#######################################################
FROM silkeh/latex:small as metapost
LABEL Author=<diestel@steloj.de>

ARG VG_BRANCH=master

COPY mp2png.sh .
RUN apk --update add curl unzip librsvg --no-cache && rm -f /var/cache/apk/* 
RUN curl -LO https://github.com/revuloj/voko-grundo/archive/${VG_BRANCH}.zip \
    && unzip ${VG_BRANCH}.zip voko-grundo-${VG_BRANCH}/smb/*.mp
RUN cd voko-grundo-${VG_BRANCH} && ../mp2png.sh # && cd ${HOME}

#######################################################
# staĝo 2: Ni bezonas Javon kaj Ant, Saxon ktp.
#######################################################
FROM ubuntu:focal

# problemo en Debian Buster: Could not perform immediate configuration on 'libnss-nis:amd64'
# vd ankaŭ https://bugs.launchpad.net/ubuntu/+source/ubuntu-release-upgrader/+bug/1899272
#FROM openjdk:jre-slim
#FROM openjdk:11.0.9-slim-buster
LABEL Author=<diestel@steloj.de>

ARG VG_BRANCH=master
ARG DEBIAN_FRONTEND=noninteractive

# libcommons-net-java, liboro-java required for ant ftp task
RUN apt-get update && apt-get install -y --no-install-recommends \
  locales openjdk-11-jre-headless \
    curl unzip rsync git cron ssh libjsch-java libcommons-net-java liboro-java ant ant-optional \
    libxalan2-java libsaxonb-java libjing-java jing sqlite3 bsdmainutils \
    dictzip lynx xsltproc rxp \
	&& rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/share/java/commons-net.jar /usr/share/ant/lib/commons-net.jar \
  && ln -s /usr/share/java/oro.jar /usr/share/ant/lib/oro.jar \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# openssh-server 	&& mkdir -p /var/run/sshd 
# libsaxonhe-java: havas problemon transformante multajn artikolojn: normalizationData.xml not found...

RUN useradd -ms /bin/bash -u 1001 formiko
WORKDIR /home/formiko
ENV REVO=/home/formiko/revo \
    VOKO=/home/formiko/voko \
    GRUNDO=/home/formiko/voko-grundo-${VG_BRANCH} \
    SAXONJAR=/usr/share/java/saxonb.jar \
    JINGJAR=/usr/share/java/jing.jar \
    ANT_OPTS=-Xmx1000m \
    LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8
# problemo kun normlaizeData.xml en Saxon-HE!
#ENV SAXONJAR /usr/share/java/Saxon-HE.jar

COPY bin/* /usr/local/bin/

#RUN mkdir /home/revo/voko && ln -s /home/revo/revo/dtd /home/revo/voko/dtd

RUN curl -LO https://github.com/revuloj/voko-grundo/archive/${VG_BRANCH}.zip \
  && unzip ${VG_BRANCH}.zip voko-grundo-${VG_BRANCH}/xsl/* voko-grundo-${VG_BRANCH}/dtd/*  voko-grundo-${VG_BRANCH}/cfg/* \
     voko-grundo-${VG_BRANCH}/dok/* voko-grundo-${VG_BRANCH}/jsc/* voko-grundo-${VG_BRANCH}/stl/* voko-grundo-${VG_BRANCH}/smb/*.gif \
     voko-grundo-${VG_BRANCH}/bin/* voko-grundo-${VG_BRANCH}/sql/* voko-grundo-${VG_BRANCH}/owl/voko.rdf \
  && ln -s ${GRUNDO} ${VOKO} && rm ${VG_BRANCH}.zip \
  && chmod go+w ${GRUNDO}/xsl \
  && chown formiko ${GRUNDO}/cfg/klasoj.xml ${GRUNDO}/xsl/revo_tez.xsl ${GRUNDO}/xsl/revohtml2.xsl ${GRUNDO}/xsl/revohtml.xsl \
  && mkdir -p revo && mkdir -p tmp/inx_tmp && mkdir -p log && chown -R formiko:users revo tmp log \
  && ln -s /usr/local/bin/jing2xml.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/gitlogart.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/gitlogxml.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/gitlogxmllst.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/gitlogxml2w.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/git_shanghitaj.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/git_forigitaj.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/git_bv_forigu_lst.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/insert-art-blobs.sh ${VOKO}/bin/ \
  && ln -s /usr/local/bin/viki_listo.sh ${VOKO}/bin/ 
COPY ant ${VOKO}/ant
COPY jav ${VOKO}/jav

#USER formiko:users

# ni poste kopios tion al ${REVO}/cfg
# ĉar ${REVO} estos injektita nur ĉe lanĉo de Formiko
COPY cfg/* /etc/
COPY --from=metapost --chown=root:root voko-grundo-${VG_BRANCH}/smb/ /home/formiko/voko/smb/

# FARENDA:
# uzu ant-regulon por krei respiro.jar...?
# prenu xml el revo - verŝajne plej bone dum lanĉo de la procesumo, por
# havi ĝin sur ekstera dosierujo kaj ne forĵeti la ŝanĝojn...
# kreu bazan vortaron el ĉio ĉi (medio, tuto...)
# pripensu kiel speguli la dosierojn al la http-servo
# eblecoj: kiel nuntempe per ftp, alternative per rsync, cvs, git (aŭ eĉ komuna dosierujo?)

## https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container
RUN ant -f $VOKO/ant/respiro.xml && touch /var/log/cron.log

HEALTHCHECK --interval=5m --timeout=3s CMD health_check_cron.sh 

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron","-f"]
