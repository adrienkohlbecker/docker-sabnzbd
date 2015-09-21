FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list && \
    apt-get update && \
    # sabnzbd deps
    apt-get install -y --force-yes software-properties-common python-software-properties git unrar unzip p7zip  curl && \
    # shr deps
    apt-get install -y --force-yes curl git mercurial && \
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

RUN curl http://homebrew.staging.cfn.aws.shr.st/shr/shr-20150920234558-linux.deb -o shr.deb && \
    dpkg -i shr.deb && \
    rm shr.deb

RUN useradd --uid 2001 --user-group --create-home sabnzbd && \
    chown -R sabnzbd /opt/nzbToMedia
USER sabnzbd

ADD . /app/sabnzbd
WORKDIR /app/sabnzbd

VOLUME ["/data"]

EXPOSE 8080

ENV SHR_EXEC_MODE development
ENV SHR_EXEC_USER sabnzbd

ENTRYPOINT ["shr", "exec", "--"]
CMD ["bin/boot", "/usr/bin/sabnzbdplus", "--config-file", "/tmp/sabnzbd.ini", "--console"]
