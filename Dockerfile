FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
 && apt-get update \
 && apt-get install -y locales \
 && locale-gen en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

RUN set -x \
 && apt-get update \
 && apt-get install -y software-properties-common python-is-python3 \
 && add-apt-repository universe \
 && add-apt-repository multiverse \
 && add-apt-repository ppa:jcfp/nobetas \
 && add-apt-repository ppa:jcfp/sab-addons \
 && apt-get update \
 && apt-get install -y sabnzbdplus par2-tbb \
 && rm -rf /var/lib/apt/lists/*

RUN set -x \
 && apt-get update \
 && apt-get install -y git unrar unzip p7zip ffmpeg curl \
 && git clone https://github.com/clinton-hall/nzbToMedia.git /opt/nzbToMedia \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/bin/unrar-nonfree /usr/local/bin/unrar

VOLUME ["/data"]

EXPOSE 8080

CMD ["/usr/bin/sabnzbdplus", "--config-file", "/data/sabnzbd.ini", "--disable-file-log"]
