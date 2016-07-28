# derived from latest debian
FROM jenkins:latest

# switch to root
USER root

# install apt-transport-https
RUN apt-get update && apt-get install -y apt-transport-https

# add docker repository
RUN echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list

# install docker
RUN apt-get update && apt-get install --force-yes -y docker-engine

# Add jenkins user to group 'docker'
RUN usermod -a -G docker jenkins

USER jenkins

