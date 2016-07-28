# derived from latest debian
FROM debian:latest

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install -y openssh-server

# install admin tools
RUN apt-get -y install mysql-client

# create sshd directory
RUN mkdir -p /var/run/sshd

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

# start named
CMD ["/usr/sbin/sshd", "-D"]
