#!/bin/bash
source ./variable.sh

#récupération des adresses IP des différents noeuds
host_ip=`cat ./host`

#si des clés ssh utilisées avec hadoop existent déjà, les efface
if test -f ~/.ssh/id_rsa
then
  rm -f ~/.ssh/*
  ssh-add -D
fi

echo -n "Génération de la clé..."
ssh-keygen -q -N "" -f $home_dir/.ssh/id_rsa &> log.txt
echo "ok"

for i in $host_ip
do
  echo "Copie de la clé sur $i"
  ./ssh_expect.EXP $i $user $pass $home_dir > log.txt
done
