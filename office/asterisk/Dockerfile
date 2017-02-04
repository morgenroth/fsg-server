FROM debian:latest
MAINTAINER Johannes Morgenroth <johannes.morgenroth@formulastudent.de>
ENV DEBIAN_FRONTEND noninteractive

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install asterisk
RUN apt-get -qq update && apt-get install -yqq asterisk asterisk-mp3 asterisk-prompt-de asterisk-modules mpg123
RUN mkdir /var/run/asterisk/; chown asterisk:asterisk /var/run/asterisk

# finally clean the container
RUN apt-get upgrade -yqq && \
    apt-get clean -yqq && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

USER asterisk
CMD ["/usr/sbin/asterisk", "-fv"]
