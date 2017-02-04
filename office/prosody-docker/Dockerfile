################################################################################
# Build a dockerfile for Prosody XMPP server
# Based on ubuntu
################################################################################

FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Lloyd Watkin <lloyd@evilprofessor.co.uk>

# install packages
RUN apt-get -qq update && apt-get install -yqq wget sudo

# Install prosody
RUN echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | tee -a /etc/apt/sources.list
RUN wget https://prosody.im/files/prosody-debian-packages.key -O- | apt-key add -
RUN apt-get update && apt-get install -yqq prosody

# Install and configure prosody
RUN sed -i '1s/^/daemonize = false;\n/' /etc/prosody/prosody.cfg.lua \
    && perl -i -pe 'BEGIN{undef $/;} s/^log = {.*?^}$/log = {\n    {levels = {min = "info"}, to = "console"};\n}/smg' /etc/prosody/prosody.cfg.lua

# finally clean the container
RUN apt-get upgrade -yqq && \
    apt-get clean -yqq && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

ADD prosody.sh /tmp/prosody.sh

EXPOSE 80 443 5222 5269 5347 5280 5281
#USER prosody
ENV __FLUSH_LOG yes
CMD ["/tmp/prosody.sh"]
