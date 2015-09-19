FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes software-properties-common python-software-properties && \
    add-apt-repository -y ppa:jcfp/ppa && \
    apt-get update && \
    apt-get install -y --force-yes  sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
    par2 python-yenc unzip unrar && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ADD sabnzbd.ini /config/sabnzbd.ini

VOLUME ["/data", "/media"]

EXPOSE 8080 9090

CMD ["/usr/bin/sabnzbdplus","--config-file","/config/sabnzbd.ini","--console"]
