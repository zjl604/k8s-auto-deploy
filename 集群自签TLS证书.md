#####etcd  
* ca.pem （ca数字证书）
* server.pem (server数字证书-服务端证书)
* server-key.pem（带key的就是私钥，用于加减秘）

#####kube-apiserver
* ca.pem
* server.pem
* server-key.pem

#####kubelet
* ca.pem
* ca-key.pem

#####kube-proxy
* ca.pem
* kube-proxy.pem
* kube-proxy-key.pem

#####kubectl（客户端访问集群，作为集群管理员，通过这个证书访问 api）
* ca.pem
* admin.pem
* admin-key.pem 

#####安装证书生成工具 cfssl：
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64  
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64  
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64  
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64  
mv cfssl_linux-amd64 /usr/local/bin/cfssl  
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson  
mv cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo

1.k8s-master 先创建一个存放 ssl 的目录
