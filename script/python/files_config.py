#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
from fonction_ip import *
import sys
def file_conf_generate(liste_files, liste_replace, path_in, path_out):
    for cpt in liste_files:
        f = open(path_in+cpt, 'r')
        text = f.read()
        f.close()

        for i in liste_replace:
            if i[0] in text:
                text = text.replace(i[0], i[1])

        if cpt == 'slaves':
            text = '\n'.join(ip[2:])
        if cpt == 'masters':
            text = ip[1]

        path2 = path_out+cpt
        files = open(path2,'w')
        files.write(text)
        files.close()



path_name=sys.argv[1]
path_data=sys.argv[2]
java_env=sys.argv[3]
path_hadoop=sys.argv[4]
path_store=sys.argv[5]

ip = ip_host()

liste_fic = ['core-site.xml','hadoop-env.sh','hdfs-site.xml','mapred-site.xml','yarn-site.xml']
liste_name_config = ['hdfs-site.xml','masters','slaves']
liste_secondary = ['hdfs-site.xml']
liste_replace = [['{ip_name}', ip[0]],['{path_name}',path_name],['{path_data}',path_data],['{java}',java_env],['{hadoop_home}', path_hadoop], ['{ip_secondary}', ip[1]], ['{path_store}', path_store]]

file_conf_generate(liste_fic, liste_replace, './Fichier_de_configuration/', './temp/')
file_conf_generate(liste_name_config, liste_replace, './Namenode_config/', './temp_name/')
file_conf_generate(liste_secondary, liste_replace, './Secondary_config/', './temp_secondary/')


