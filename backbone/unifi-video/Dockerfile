# derived from latest ubuntu
FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

# Add Tini
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# add unifi and mongo repo
ADD ./100-ubnt.list /etc/apt/sources.list.d/100-ubnt.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

## install packages
RUN apt-get -qq update && apt-get install -yqq mongodb-10gen jsvc sudo psmisc lsb-release openjdk-8-jre-headless

# add unifi and mongo repo
ADD https://dl.ubnt.com/firmwares/unifi-video/3.7.1/unifi-video_3.7.1~Ubuntu16.04_amd64.deb unifi-video_3.7.1~Ubuntu16.04_amd64.deb
RUN dpkg -i unifi-video_3.7.1~Ubuntu16.04_amd64.deb; apt-get install -fy

# finally clean the container
RUN apt-get upgrade -yqq && \
    apt-get clean -yqq && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

# add unifi default config
ADD ./unifi-video.default /etc/default/unifi-video
RUN mkdir -p /var/run/unifi-video; chown unifi-video:unifi-video /var/run/unifi-video

# start unifi-video
EXPOSE 7447 7446 7445 7443 7080 6666
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
WORKDIR /usr/lib/unifi-video
USER unifi-video

#
CMD ["java", "-cp", "/usr/share/java/commons-daemon.jar:/usr/lib/unifi-video/lib/airvision.jar", "-Dav.tempdir=/var/cache/unifi-video", "-Djava.security.egd=file:/dev/urandom", "-Djava.library.path=/usr/lib/unifi-video/lib", "-Djava.awt.headless=true", "-Djavax.net.ssl.trustStore=/usr/lib/unifi-video/data/ufv-truststore", "-Dfile.encoding=UTF-8", "-Xmx8349M", "com.ubnt.airvision.Main", "start"]
