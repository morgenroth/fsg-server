# derived from latest debian
FROM debian:latest

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install --force-yes -y git cron munin munin-plugins-extra 

# create necessary folders
RUN mkdir -p /var/log/munin /var/lib/munin /etc/munin /var/cache/munin

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

# copy template
RUN git clone https://github.com/munin-monitoring/contrib.git /opt/contrib
RUN cp -rp /opt/contrib/templates/munstrap/templates/ /etc/munin/
RUN cp -rp /opt/contrib/templates/munstrap/static/ /etc/munin/

# start services
ADD ./start-munin.sh /root/start-munin.sh
RUN chmod +x /root/start-munin.sh
CMD ["/root/start-munin.sh"]
