# derived from latest debian
FROM debian:latest

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install -y supervisor nginx php5-fpm php5-mysql php5-mcrypt php5-gd php5-memcached php5-curl

# create necessary folders
RUN mkdir -p /var/log/supervisor /etc/nginx /var/run/php5-fpm

# Disable daemon mode of nginx
RUN sed -i 's/worker_processes 4;/worker_processes 4;\ndaemon off;/g' /etc/nginx/nginx.conf

# Set php timezone
RUN sed -i 's/;date.timezone =/date.timezone = Europe\/Berlin/g' /etc/php5/fpm/php.ini

# copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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
CMD ["/usr/bin/supervisord"]
