############################################################
# Dockerfile to install Jboss HornetQ Server
############################################################

FROM localhost:5000/java:1.7_71

RUN mkdir -p /usr/jboss

WORKDIR /usr/jboss
ADD install/jboss-eap-6.4.0.tar.gz ./
ADD scripts ./

ENV JAVA_HOME /usr/java/jdk1.7.0_71
ENV JBOSS_HOME /usr/jboss/jboss-eap-6.4

#Generate two jms-queues max-size after _
RUN ./config_hornetq.sh DevQueue_100000 DevQueue2_300000

#hornetq notes list in the format below for runtime usage
#host:port host2:port
ENV NODES_LIST ""

EXPOSE 5445

ENTRYPOINT ["./start_config_jboss.sh"]
