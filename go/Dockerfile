############################################################
# Dockerfile to install Go 1.4
# Based on RHEL7.0 Image
############################################################

FROM localhost:5000/cepro/rhel:7.0

ADD go1.4.linux-amd64.tar.gz /usr/local

ENV GOROOT /go
RUN export PATH=$PATH:/usr/local/go/bin:$GOROOT/bin

# Set the file maintainer (your name - the file's author)
MAINTAINER Matheus Cunha
