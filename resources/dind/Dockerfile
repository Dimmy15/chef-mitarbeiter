FROM ubuntu:14.04
MAINTAINER timm@hojoki
#Origin from jerome.petazzoni@docker.com

# Let's start with some basic stuff.
RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates lxc

# Install Docker from Docker Inc. repositories.
RUN apt-get install -qqy apt-transport-https
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update -qq
RUN apt-get install -qqy lxc-docker

RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean
# Jenkins Version from 09.09.2014
ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /var/jenkins_home

#ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
EXPOSE 4444

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
ADD ./startup.sh /root/startup.sh
RUN chmod +x /usr/local/bin/wrapdocker /root/startup.sh


# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["/root/startup.sh"]
