#!/bin/bash
user="**"
pass="**"
java_version="java-1.7.0-openjdk-amd64"
hadoop_ver="hadoop-2.7.1"

home_dir="/home/$user"

path_hadoop_install="$home_dir/Documents"
path_hadoop="$path_hadoop_install/$hadoop_ver"
path_hadoop_file="$path_hadoop/etc/hadoop"
path_store="$home_dir/hdfs_storage"
path_data="$path_store/data"
path_name="$path_store/name"


java_env="/usr/lib/jvm/$java_version"

hadoop_tar_gz="$hadoop_ver.tar.gz"
download_ver="http://apache.crihan.fr/dist/hadoop/common/$hadoop_ver/$hadoop_tar_gz"
sha_resum="https://dist.apache.org/repos/dist/release/hadoop/common/$hadoop_ver/$hadoop_tar_gz.asc"
keys_hadoop="https://dist.apache.org/repos/dist/release/hadoop/common/KEYS"
