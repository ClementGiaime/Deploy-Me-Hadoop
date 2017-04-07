# Deploy Me Hadoop
Deploy Me Hadoop est un script de déploiment Hadoop v2.x (V2.3 non comprise) principalement en shell.

# Comment ça fonction
* Télécharger Deploy-me-Hadoop
* Extraire le .zip
```
unzip Deploy-me-Hadoop-master
cd Deploy-me-Hadoop-master
```
* Modification du fichier variable.sh dans Deploy-me-Hadoop-master/script/variable.sh

Variable.sh contient les variables(logique) pour le deploiment de hadoop
  
  >* La version de hadoop que l'on veut déployer `hadoop_ver="hadoop-2.7.1"`
  >* Le dossier JAVA_HOME qui se situe dans /usr/lib/jvm/$java_version `java_version="java-1.8.0-openjdk-i386"`
  >* L'utilisateur `user="**"`
  >* Le mot de passe `pass="**"`
  >* Le dossier d'installation de hadoop `path_hadoop_install="$home_dir/Documents"`
  >* etc ...

* Ajout ou modification du fichier host qui contient les @ip des machines ou l'on veut installer hadoop

Le fichier host doit obligatoirement avoir un namenode, un secondary namenode et 1 à n  datanode

>* Le # devant un @ip désigne le namenode
>* Le _ devant un @ip désigne le secondary namenode

Exemple du fichier host:
```
192.168.1.5
192.168.1.2
_192.168.1.3
192.168.1.6
#192.168.1.1
```
namenode est 192.168.1.1

secondary est 192.168.1.3

datanodes sont 192.168.1.6, 192.168.1.2, 192.168.1.5


* Si besoin vous pouvez modifier les fichiers de hadoop pour avoir un autre configuration dans les dossiers 
```
script/Fichier_de_configuration #Fichier configuration de base pour les datanodes
script/Namenode_config
script/Secondary_config
```

* Donner les droits pour exécuter le script run
```
chmod 744 ./run
```
* puis lancer le script run
```
./run
```
