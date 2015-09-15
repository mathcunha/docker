#!/bin/bash
/usr/jboss/jboss-eap-6.4/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0 &
sleep 20

echo "" > /usr/jboss/cluster.jb
i=0
for pair in "${NODES_LIST}"
do
    i=$((i+1))
        IFS=':' read -a array <<< "$pair"
    h=${array[0]}
    p=${array[1]}
        echo "/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=node0$i:add(host=$h, port=$p)" >> /usr/jboss/cluster.jb
        echo "/subsystem=messaging/hornetq-server=default/cluster-connection=my-cluster:add(connector-ref=netty,static-connectors=["node0$i"],cluster-connection-address=jms)" >> /usr/jboss/cluster.jb
done

/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --file=/usr/jboss/cluster.jb

/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --command=':shutdown(restart=false)'

/usr/jboss/jboss-eap-6.4/bin/standalone.sh -c standalone-full-ha.xml -b ${HOSTNAME} -Djboss.bind.address.management=${HOSTNAME}
