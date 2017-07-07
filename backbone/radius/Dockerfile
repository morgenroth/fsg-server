# derived from latest debian
FROM debian:latest

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq ca-certificates ssl-cert freeradius

# install radius plugins support
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq freeradius-ldap freeradius-mysql

# install python support
RUN EBIAN_FRONTEND=noninteractive apt-get install -yqq python python-simplejson python-httplib2 python-mysqldb

# finally clean the container
RUN apt-get -qq update && \
    apt-get upgrade -yqq && \
    apt-get clean -yqq && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

# temp directory
RUN mkdir /tmp/radiusd && chown freerad:freerad /tmp/radiusd

# define a health check
HEALTHCHECK CMD /data/radius-python/radtest.sh | grep "rad_recv: Access-Accept"

# start radius server
CMD ["/usr/sbin/freeradius", "-f"]
