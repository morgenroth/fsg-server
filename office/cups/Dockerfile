# derived from latest debian
FROM debian:latest

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install --force-yes -y vim whois cups cups-pdf

# install Xerox driver
ADD ./Xeroxv5Pkg-Linuxx86_64-5.20.558.3113.deb /root/Xeroxv5Pkg-Linuxx86_64-5.20.558.3113.deb
RUN dpkg -i /root/Xeroxv5Pkg-Linuxx86_64-5.20.558.3113.deb

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
ADD start_cups.sh /root/start_cups.sh
RUN chmod +x /root/start_cups.sh
CMD ["/root/start_cups.sh"]
