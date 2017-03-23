#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
from fonction_ip import *
import sys
def file_conf_generate(liste_files, liste_replace, path_in, path_out):

    #pour chaque tour de boucle cpt prend le nom d'un fichier
    for cpt in liste_files:
        #Ouvre le fichier en lecture
        f = open(path_in+cpt, 'r')
        #Récupère le contenue dans un variable
        text = f.read()
        #Fermeture du fichier
        f.close()

        #pour chaque tour de boucle i prend une liste de deux éléments ["{ip_name}, "192.168.1.1"] puis ["{path_name}","192.168.1.1"] etc
        for i in liste_replace:

            #Si l'élément 1 de i (ex : {ip_name}) et présent dans la liste on le remplace par l'élément 2 de i ("192.168.1.1")
            if i[0] in text:
                text = text.replace(i[0], i[1])
        #Si le fichier s'appel slaves on donne toute les @ip des Datanodes
        if cpt == 'slaves':
            text = '\n'.join(ip[2:])
        #Si le fichier s'appel master on donne @ip du secondary
        if cpt == 'masters':
            text = ip[1]

        #On écrit dans le nouveau fichier 
        path2 = path_out+cpt
        files = open(path2,'w')
        files.write(text)
        files.close()


#Récupère les variables passé en paramètre
path_name=sys.argv[1]
path_data=sys.argv[2]
java_env=sys.argv[3]
path_hadoop=sys.argv[4]
path_store=sys.argv[5]

#Récupère une liste des @ip qui trie [NameNode,Secondary,Data1,Data2]
ip = ip_host()

#Liste des fichiers de config hadoop dans script/Fichier_de_configuration qui vont être modifié
liste_fic = ['core-site.xml','hadoop-env.sh','hdfs-site.xml','mapred-site.xml','yarn-site.xml']

#Liste des fichiers de config hadoop pour le namenode dans script/Namenode_config
liste_name_config = ['hdfs-site.xml','masters','slaves']

#Liste des fichiers de config hadoop pour le namenode dans script/Secondary_config
liste_secondary = ['hdfs-site.xml']

#Quel éléments qui va être remplacé et par quoi
#Exemple de fichier:
#<property>
#<name>fs.defaultFS</name>
#<value>hdfs://{ip_name}:9000</value>
#</property>#
#

#Ici le {ip_name} va être remplacé par ip du namenode
liste_replace = [['{ip_name}', ip[0]],['{path_name}',path_name],['{path_data}',path_data],['{java}',java_env],['{hadoop_home}', path_hadoop], ['{ip_secondary}', ip[1]], ['{path_store}', path_store]]

#Lance la configuration des fichiers
file_conf_generate(liste_fic, liste_replace, './Fichier_de_configuration/', './temp/')
file_conf_generate(liste_name_config, liste_replace, './Namenode_config/', './temp_name/')
file_conf_generate(liste_secondary, liste_replace, './Secondary_config/', './temp_secondary/')
