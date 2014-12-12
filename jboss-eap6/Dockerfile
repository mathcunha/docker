############################################################
# Dockerfile to install JBoss-Slave
# Based on RHEL7/java Image
############################################################

FROM localhost:5000/cepro/java:latest

RUN mkdir -p /usr/jboss
WORKDIR /usr/jboss

ADD jboss-eap-6.1-dese.tar.gz /usr/jboss

ENV JAVA_HOME /usr/java/jdk1.7.0_71
ENV JBOSS_HOME /usr/jboss/jboss-eap-6.1

EXPOSE 9999

ENTRYPOINT ["/usr/jboss/jboss-eap-6.1/bin/domain.sh", "--host-config=host-slave.xml -Djboss.domain.master.address=10.10.10.10 -Djboss.bind.address=0.0.0.0 -Xmx=256m -Xms=256m"]

# Set the file maintainer (your name - the file's author)
MAINTAINER Matheus Cunha
