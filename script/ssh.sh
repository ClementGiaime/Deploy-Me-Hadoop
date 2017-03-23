#!/bin/bash
source ./variable.sh

#Script qui genere un paire de clef RSA et distribu la clef public au differents noeuds

#recuperation des adresses IP des differents noeuds
host_ip=`cat ./host`

#si des clef ssh(id_rsa) existent déjà on supprime
if test -f ~/.ssh/id_rsa
then
  rm -f ~/.ssh/id_rsa*
  ssh-add -D
fi

echo -n "Génération de la clef..."
ssh-keygen -q -N "" -f $home_dir/.ssh/id_rsa &> log.txt
echo "ok"

#Copie de la clef sur les noeuds
for i in $host_ip
do
  echo "Copie de la clef sur $i"
  ./ssh_expect.exp $i $user $pass $home_dir > log.txt
done

#set $host_ip
#scp ~/.ssh/id_rsa* $user@$1:~/.ssh/
#for i in $host_ip
#do
#./add_authorise.exp $i $user $1
#done
