#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
from fonction_ip import *

ip = ip_host()

file_ip = open('./host', 'w')
for i in ip:
	file_ip.write(i+" ")
file_ip.close()
