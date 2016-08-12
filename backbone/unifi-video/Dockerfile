# derived from latest ubuntu
FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install dependencies
RUN apt-get -qq update && apt-get install -yqq adduser sudo psmisc lsb-release mongodb-server default-jre-headless jsvc software-properties-common 

# Install Java.
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer

# add unifi and mongo repo
ADD http://dl.ubnt.com/firmwares/unifi-video/3.3.0/unifi-video_3.3.0~Debian7_amd64.deb unifi-video_3.3.0~Debian7_amd64.deb
RUN dpkg -i unifi-video_3.3.0~Debian7_amd64.deb

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

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
WORKDIR /usr/lib/unifi-video
USER unifi-video

CMD ["java", "-cp", "/usr/share/java/commons-daemon.jar:/usr/lib/unifi-video/lib/airvision.jar", "-Djava.secury.egd=file:/dev/./urandom", "-Xmx1024M", "-Djava.library.path=/usr/lib/unifi-video/lib", "-Djava.awt.headless=true", "-Dfile.encoding=UTF-8", "com.ubnt.airvision.Main", "start"]
