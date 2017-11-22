FROM coppit/mumble-server
MAINTAINER Johannes Morgenroth <johannes.morgenroth@formulastudent.de>
ENV DEBIAN_FRONTEND noninteractive

# Add Tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# install packages
RUN apt-get update && apt-get install -y websockify python-pkg-resources supervisor nginx

# create necessary folders
RUN mkdir -p /var/log/supervisor /etc/nginx

# copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
