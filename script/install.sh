#!/bin/bash
source ./variable.sh
#récupération des adresses IP des différents noeuds
host_ip=`cat ./host`

echo -n "Extraction des fichiers... "

#extraction des fichiers hadoop
tar xvf $hadoop_tar_gz > log.txt
echo "ok"

mkdir temp temp_name temp_secondary

echo -n "Configuration des fichiers... "
./python/files_config.py $path_name $path_data $java_env $path_hadoop $path_store
echo "ok"

#Copie des fichiers de configuration de Bases
cp ./temp/* ./$hadoop_ver/etc/hadoop/

#Copie de Hadoop sur tout les nodes avec config de base
for i in $host_ip
do
  echo -n "Copie de $hadoop_ver sur $i... "
  scp -r $hadoop_ver $user@$i:$path_hadoop_install > log.txt
  echo "ok"
done

#Ajout des fichiers de configuration sur NameNode et Secondary
echo -n "Copie des fichiers de config NameNode/Secondary... "
set $host_ip
scp ./temp_name/* $user@$1:$path_hadoop_file > log.txt

scp ./temp_secondary/* $user@$2:$path_hadoop_file > log.txt
echo "ok"

rm -Rf ./temp ./temp_name ./temp_second

