#!/bin/bash
/usr/jboss/jboss-eap-6.4/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0 &
echo "" > /usr/jboss/cluster.jb
i=0
nodes=""
VAR="${NODES_LIST}"
echo "$VAR"
sleep 20

if [ -z "$VAR" ]; then
	echo "NODE_LIST env is empty"
else
        IFS=' ' read -a endpoint <<< "$VAR"
	for pair in "${endpoint[@]}"
	do
    		i=$((i+1))
    		IFS=':' read -a array <<< "$pair"
    		nodes="$nodes,node$i"
    		h=${array[0]}
    		p=${array[1]}
        	echo "/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=node$i:add(host=$h, port=$p)" >> /usr/jboss/cluster.jb
		echo "/subsystem=messaging/hornetq-server=default/remote-connector=node$i:add(socket-binding=node$i)" >> /usr/jboss/cluster.jb
	done

	IFS=':' read -a array <<< "${NODE_ADDRESS}"
	h=${array[0]}
	p=${array[1]}
	echo "/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=LOCAL:add(host=$h,port=$p)" >> /usr/jboss/cluster.jb
	echo "/subsystem=messaging/hornetq-server=default/remote-connector=LOCAL:add(socket-binding=LOCAL)" >> /usr/jboss/cluster.jb

	#removing first ,
        nodes=$(echo $nodes | sed 's/^,//g')
	echo "/subsystem=messaging/hornetq-server=default/cluster-connection=my-cluster:add(connector-ref=LOCAL,static-connectors=["$nodes"],cluster-connection-address=jms)" >> /usr/jboss/cluster.jb

	/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --file=/usr/jboss/cluster.jb
fi

/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --command=':shutdown(restart=false)'
/usr/jboss/jboss-eap-6.4/bin/standalone.sh -c standalone-full-ha.xml -b ${HOSTNAME} -Djboss.bind.address.management=${HOSTNAME}
