#!/bin/bash
##### 证书生成工具 cfssl 部署：
wget -P /usr/local/bin/ -O "cfssl" https://pkg.cfssl.org/R1.2/cfssl_linux-amd64  
wget -P /usr/local/bin/ -O "cfssljson" https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64  
wget -P /usr/local/bin/ -O "cfssl-certinfo" https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64  
chmod +x /usr/local/bin/*


生成证书的一个模板文件:  
cfssl print-defaults config > config.json  

请求颁发证书的一个文件,这个 csr.json 具体申明证书包含的信息：比如证书的域名，哪个域名去用这个证书  
CN具体标识你这个域，还有key里面就是你加密的方式，还有name里面涉及证书的一些信息，比如哪个国家，哪个地区
cfssl print-defaults csr > csr.json  

1.k8s-master 先创建一个存放 ssl 的目录  
2.上传一个生成证书的脚本 certificate.sh
  脚本内容里面第一个 ca-config.json，主要是过期时间，还有引用 profiles 这里面的 kubernetes 这个配置段去生成证书  
  第二个 ca-csr.json 生成的这个证书他具体的信息，这些信息在我去访问集群的时候，从这里提取出来判断我有没有权限访问  
  这两个就是生成CA的，一个是CA的配置文件，一个CA的证书，也就是去生成 ca.pem,和 ca-key.pem 这两个  
  然后接下去生成 server 的证书，这个server的证书 用于 api http，好比

