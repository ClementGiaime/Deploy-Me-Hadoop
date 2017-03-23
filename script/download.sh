#!/bin/bash
source ./variable.sh

#variable de test pour sortire de la boucle quand = True
test_install=False

#boucle permettant de ré-itérer le téléchargement des fichiers en cas d'échec
while [ $test_install = False ]
do

  #test si les fichiers hadoop ont déjà ete téléchargé et extraits
  if test ! -d ./$hadoop_ver
  then

    #test si les fichiers hadoop ont déjà été téléchargé
    if test ! -f ./$hadoop_tar_gz
    then
      echo -n "Téléchagement de $hadoop_tar_gz... "
      wget -o log.txt $download_ver
      echo " ok"
    fi

    #téléchargement du résumé et des clés permettant
    #de vérifier intégrité des fichiers hadoop
    if test -d KEYS
    then
      rm -f KEYS
    fi

    if test -d $hadoop_tar_gz.asc
    then
      rm -f $hadoop_tar_gz.asc
    fi

    echo -n "Téléchagement du résumé... "
    wget -o log.txt $sha_resum
    echo "ok"

    echo  -n "Téléchagement des clés... "
    wget -o log.txt $keys_hadoop
    echo "ok"

    echo -n "Importation des clés... "
    gpg --import KEYS &> log.txt
    echo "ok"

    #Vérification de hadoop.tar.gz
    echo -n "Vérification de $hadoop_tar_gz... "
    gpg --verify $hadoop_tar_gz.asc $hadoop_tar_gz &> log.txt
    retval=$?

    rm KEYS
    rm $hadoop_tar_gz.asc

    #si fichiers hadoop n'est pas corrumpu
    if [ $retval -eq 0 ]
    then
      echo "ok"
      #modification valeur de la variable de test
      test_install=True
    else
      echo "erreur"
      #sinon suppression de l'archive corrompue
      rm $hadoop_tar_gz
    fi
  else
    echo "Hadoop déja téléchargé"
    test_install=True
  fi
done
