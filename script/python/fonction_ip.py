#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

def ip_host():
    file_host = open('../host', 'r')
    ip = file_host.readlines()
    file_host.close()
    temp_ip = []

    for i in ip:
        if '#' in i:
            namenode = i
            namenode = namenode.replace('#', '')
            namenode = namenode.replace('\n', '')
        elif '_' in i:
            secondary = i
            secondary = secondary.replace('_','')
            secondary = secondary.replace('\n','')
        else:
            temp_ip.append(i.replace('\n', ''))
    ip = []
    ip.append(namenode)
    ip.append(secondary)
    ip.extend(temp_ip)

    cpt=0
    for i in ip:
        if i == '':
            cpt=cpt+1

    i=0
    while(i<cpt):
        ip.remove('')
        i=i+1
    return ip
