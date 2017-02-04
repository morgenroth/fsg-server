FROM coppit/mumble-server
MAINTAINER Johannes Morgenroth <johannes.morgenroth@formulastudent.de>
ENV DEBIAN_FRONTEND noninteractive

# Add Tini
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

USER mumble-server
CMD ["/usr/sbin/murmurd", "-ini", "/data/mumble-server.ini", "-fg"]
