FROM debian:latest
MAINTAINER Johannes Morgenroth <johannes.morgenroth@formulastudent.de>

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install --force-yes -y perl perl-modules libnet-pcap-perl libterm-readline-gnu-perl libterm-readkey-perl libnetaddr-ip-perl libreadonly-perl libreadonly-xs-perl libio-string-perl libnet-arp-perl

# install packages
ADD https://ams-ix.net/downloads/arpsponge/3.17.7/arpsponge_3.17.7_all.deb arpsponge_3.17.7_all.deb
RUN dpkg -i arpsponge_3.17.7_all.deb

# add noc group
RUN groupadd noc

# finally clean the container
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

# start services
CMD ["/usr/local/sbin/arpsponge", "--verbose"]

