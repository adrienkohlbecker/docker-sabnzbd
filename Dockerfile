FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes software-properties-common python-software-properties git unrar unzip p7zip && \
    add-apt-repository -y ppa:jcfp/ppa && \
    add-apt-repository -y ppa:kirillshkrogalev/ffmpeg-next && \
    apt-get update && \
    apt-get install -y --force-yes  sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush ffmpeg \
    par2 python-yenc unzip unrar && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN git clone https://github.com/clinton-hall/nzbToMedia.git /opt/nzbToMedia

RUN useradd --uid 2001 --user-group --create-home sabnzbd && \
    chown -R sabnzbd /opt/nzbToMedia
USER sabnzbd

ADD sabnzbd.ini /config/sabnzbd.ini
ADD boot.sh /config/boot.sh
ADD nzbToMedia.cfg /opt/nzbToMedia/nzbToMedia.cfg

VOLUME ["/data"]

EXPOSE 8080

CMD ["/config/boot.sh", "/usr/bin/sabnzbdplus", "--config-file", "/tmp/sabnzbd.ini", "--console"]
