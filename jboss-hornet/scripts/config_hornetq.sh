#!/bin/bash
/usr/jboss/jboss-eap-6.4/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0 &
sleep 10

/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh --file=/usr/jboss/global.jb -c

for pair in "$@"
do
    IFS='_' read -a array <<< "$pair"
    q=${array[0]}
    s=${array[1]}

    echo "$pair configing queue $q with size $s"
    sed -e 's/FILA/'"$q"'/g;s/QUEUE_SIZE/'"$s"'/g' /usr/jboss/queue.template > /usr/jboss/$q.jb
    /usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --file=/usr/jboss/$q.jb
done

/usr/jboss/jboss-eap-6.4/bin/jboss-cli.sh -c --command=':shutdown(restart=false)'
exit 0
