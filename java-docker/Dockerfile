############################################################
# Dockerfile to install java
# Based on RHEL7 Image
############################################################

FROM localhost:5000/cepro/rhel:6.5

RUN mkdir -p /usr/java/
WORKDIR /usr/java/

ADD jdk-7u71-linux-x64.gz /usr/java/

ENV JAVA_HOME /usr/jboss/jdk1.7.0_71

RUN ln -s /usr/java/jdk1.7.0_71/bin/java /usr/bin/java
RUN ln -s /usr/java/jdk1.7.0_71/bin/javac /usr/bin/javac


# Set the file maintainer (your name - the file's author)
MAINTAINER Maintaner Mathcunha
