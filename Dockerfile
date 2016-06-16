FROM kohlby/base:latest

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes software-properties-common python-software-properties git unrar unzip p7zip par2 python-yenc && \
    add-apt-repository -y ppa:jcfp/ppa && \
    add-apt-repository -y ppa:kirillshkrogalev/ffmpeg-next && \
    apt-get update && \
    apt-get install -y --force-yes sabnzbdplus ffmpeg && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN git clone https://github.com/clinton-hall/nzbToMedia.git /opt/nzbToMedia

RUN groupadd --gid 2000 media && \
    useradd --uid 2001 --gid 2000 --create-home sabnzbd && \
    chown -R sabnzbd:media /opt/nzbToMedia && \
    mkdir /data && \
    chown -R sabnzbd:media /data
USER sabnzbd

ADD . /app/sabnzbd
WORKDIR /app/sabnzbd

VOLUME ["/data"]

EXPOSE 8080

ENV SHR_EXEC_USER sabnzbd
CMD ["bin/boot", "/usr/bin/sabnzbdplus", "--config-file", "/tmp/sabnzbd.ini", "--console"]
