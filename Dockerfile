FROM jenkins:latest

ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get update \
     && apt-get install -y sudo \
     && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN (curl -sSL https://get.docker.com/ | sh) && (curl -sSL https://get.docker.com/gpg | sudo apt-key add -)

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER root
COPY Computerdatabase/ /var/jenkins_home/jobs/Computerdatabase/

ENV DOCKER_HOST tcp://docker:2375

EXPOSE 8080
