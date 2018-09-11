#!/bin/bash
##### 证书生成工具 cfssl 部署：
wget -P /usr/local/bin/ -O "cfssl" https://pkg.cfssl.org/R1.2/cfssl_linux-amd64  
wget -P /usr/local/bin/ -O "cfssljson" https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64  
wget -P /usr/local/bin/ -O "cfssl-certinfo" https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64  
chmod +x /usr/local/bin/*

##### 创建 CA 证书配置
mkdir /root/ssl
cd /root/ssl
cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
         "expiry": "87600h",
         "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ]
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
    "CN": "kubernetes",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing",
      	    "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

##### 生成 CA 证书和私钥 #####
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

##### 分发证书,把 /root/ssl 下生成的 ca.pem , ca-key.pem ca.csr 拷贝到 k8s ssl目录下 #####
##### 创建证书目录 #####
mkdir -p /opt/kubernetes/ssl
##### 拷贝证书,如果有多个mast，请scp 到另外master，我这里只有一个master #####
cp ca.pem ca-key.pem ca.csr /opt/kubernetes/ssl

#-----------------------

cat > server-csr.json <<EOF
{
    "CN": "kubernetes",
    "hosts": [
      "127.0.0.1",
      "172.16.18.2",
      "172.16.18.3",
      "172.16.18.4",
      "172.16.18.5",
      "10.10.10.1",
      "kubernetes",
      "kubernetes.default",
      "kubernetes.default.svc",
      "kubernetes.default.svc.cluster",
      "kubernetes.default.svc.cluster.local"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "BeiJing",
            "ST": "BeiJing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server

#-----------------------

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "system:masters",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin

#-----------------------

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy



