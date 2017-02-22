#!/bin/bash
source ./variable.sh

#récupération des adresses IP des différents noeuds
host_ip=`cat ./host`

#si des clés ssh existent déjà
if test -f ~/.ssh/id_rsa
then
  rm -f ~/.ssh/*
  ssh-add -D
fi

echo -n "Génération de la clef..."
ssh-keygen -q -N "" -f $home_dir/.ssh/id_rsa &> log.txt
echo "ok"

for i in $host_ip
do
  echo "Copie de la clef sur $i"
  ./ssh_expect.exp $i $user $pass $home_dir > log.txt
done
