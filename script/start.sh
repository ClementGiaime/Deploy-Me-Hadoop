#!/bin/bash
source ./variable.sh
host_ip=`cat ./host`

#connection via ssh sur chaque noeud et paramétrage des droits sur les fichiers hadoop
for i in $host_ip
do
  ssh $user@$i chmod -R 755 $path_hadoop
done

#éxécution des commandes de démarrage des services hadoop

set $host_ip

./start_expect.exp $path_hadoop

echo "Rapport :\n\n"
for i in $host_ip
do
 ssh $user@$i "cat $path_data/current/VERSION"
done

rm -rf $hadoop_ver
