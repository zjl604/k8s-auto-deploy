#!/bin/bash

##### etcd 部署的版本 ： v 3.2.24
wget -P /root/ https://github.com/etcd-io/etcd/releases/download/v3.2.24/etcd-v3.2.24-linux-amd64.tar.gz
tar zxvf /root/etcd-v3.2.24-linux-amd64.tar.gz

#### 拷贝二进制文件到 本机 k8s-master 的 kubernetes bin目录里
cp /root/etcd-v3.2.24-linux-amd64/etcd /opt/kubernetes/bin/
cp /root/etcd-v3.2.24-linux-amd64/etcdctl /opt/kubernetes/bin/

#### 拷贝二进制文件到 k8s-node01 的 kubernetes bin目录里
scp /root/etcd-v3.2.24-linux-amd64/etcd root@172.16.18.3:/opt/kubernetes/bin/
scp /root/etcd-v3.2.24-linux-amd64/etcdctl root@172.16.18.3:/opt/kubernetes/bin/

#### 拷贝二进制文件到 k8s-node02 的 kubernetes bin目录里
scp /root/etcd-v3.2.24-linux-amd64/etcd root@172.16.18.4:/opt/kubernetes/bin/
scp /root/etcd-v3.2.24-linux-amd64/etcdctl root@172.16.18.4:/opt/kubernetes/bin/

#### 拷贝二进制文件到 k8s-node03 的 kubernetes bin目录里
scp /root/etcd-v3.2.24-linux-amd64/etcd root@172.16.18.5:/opt/kubernetes/bin/
scp /root/etcd-v3.2.24-linux-amd64/etcdctl root@172.16.18.5:/opt/kubernetes/bin/

