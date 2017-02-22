#!/bin/bash
source ./variable.sh

#variable de test
test_install=False

#boucle permettant de ré-itérer le téléchargement des fichiers en cas d'échec
while [ $test_install = False ]
do

  #test si les fichiers hadoop ont déjà été téléchargés et extraits
  if test ! -d ./$hadoop_ver
  then

    #test si les fichiers hadoop ont déjà été extraits
    if test ! -f ./$hadoop_tar_gz
    then
      echo -n "Téléchagement de $hadoop_tar_gz... "
      wget -o log.txt $download_ver
      echo " ok"
    fi
    
    
    if test -d KEYS
    then
      rm -f KEYS
    fi
    
    if test -d $hadoop_tar_gz.asc
    then
      rm -f $hadoop_tar_gz.asc
    fi
    
    #téléchargement du résumé et des clés permettant
    #de vérifier intégrité des fichiers hadoop

    echo -n "Téléchagement du résumé... " #Téléchagement du résumé
    wget -o log.txt $sha_resum
    echo "ok"

    echo  -n "Téléchagement des clés... " #Téléchagement des clés
    wget -o log.txt $keys_hadoop
    echo "ok"

    echo -n "Importation des clés... " #Importation des clés
    gpg --import KEYS &> log.txt
    echo "ok"

    #Vérification de hadoop.tar.gz
    echo -n "Vérification de $hadoop_tar_gz..."
    gpg --verify $hadoop_tar_gz.asc $hadoop_tar_gz &> log.txt
    retval=$?

    rm KEYS
    rm $hadoop_tar_gz.asc

    #si fichiers hadoop n'est pas corrumpu
    if [ $retval -eq 0 ]
    then
      echo "ok"
      test_install=True #modification valeur de la variable de test
    else
      echo "erreur"
      rm $hadoop_tar_gz #sinon suppression de l'archive corrompue
    fi
  else
    echo "Hadoop déja téléchargé"
    test_install=True
  fi
done


echo -n "Extraction des fichiers... "

#récupération des adresses IP des différents noeuds
host_ip=`cat ./host`

#extraction des fichiers hadoop
tar xvf $hadoop_tar_gz > log.txt
echo "ok"

mkdir temp temp_name temp_secondary

echo -n "Configuration des fichiers... "
./python/files_config.py $path_name $path_data $java_env $path_hadoop $path_store
echo "ok"

#Copie des fichiers de configuration de Bases
cp ./temp/* ./$hadoop_ver/etc/hadoop/

#Installation de Hadoop
#on parcourt la liste des noeuds
for i in $host_ip
do
  echo -n "Copie de $hadoop_ver sur $i... "
  scp -r $hadoop_ver $user@$i:$path_hadoop_install > log.txt # copie des fichiers hadoop téléchargés sur chaque noeud
  echo "ok"
done

#Ajout des fichiers de configuration sur NameNode et Secondary
set $host_ip
scp ./temp_name/* $user@$1:$path_hadoop_file > log.txt

scp ./temp_secondary/* $user@$2:$path_hadoop_file > log.txt

rm -Rf ./temp ./temp_name ./temp_second
echo ""
