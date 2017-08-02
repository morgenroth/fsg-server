FROM ubuntu:latest
MAINTAINER Johannes Morgenroth <johannes.morgenroth@formulastudent.de>
ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get update && apt-get install -y websockify python-pkg-resources

# Add Tini
ENV TINI_VERSION v0.15.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["/usr/bin/websockify", "--ssl-target", "64837", "mumble:64838"]
