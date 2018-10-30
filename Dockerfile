FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
 && apt-get update \
 && apt-get install -y locales \
 && locale-gen en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

RUN set -x \
 && apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository universe \
 && add-apt-repository multiverse \
 && add-apt-repository ppa:jcfp/nobetas \
 && add-apt-repository ppa:jcfp/sab-addons \
 && apt-get update \
 && apt-get install -y sabnzbdplus python-sabyenc par2-tbb python-yenc \
 && rm -rf /var/lib/apt/lists/*

RUN set -x \
 && apt-get update \
 && apt-get install -y git unrar unzip p7zip ffmpeg \
 && git clone https://github.com/clinton-hall/nzbToMedia.git /opt/nzbToMedia \
 && rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

EXPOSE 8080

CMD ["/usr/bin/sabnzbdplus", "--config-file", "/data/sabnzbd.ini", "--disable-file-log"]
