#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
from fonction_ip import *

#Récupère une liste des @ip qui trie [NameNode,Secondary,Data1,Data2]
ip = ip_host()

#Crée un fichier host dans script/
file_ip = open('./host', 'w')

#Ajoute ligne par ligne un élément de la liste dans le fichier host
#NameNode
#Secondary
#Data1
#Data2
for i in ip:
	file_ip.write(i+" ")
file_ip.close()
