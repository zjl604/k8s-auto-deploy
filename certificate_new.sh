#!/bin/bash
##### 证书生成工具 cfssl 部署：
wget -P /usr/local/bin/ -O "cfssl" https://pkg.cfssl.org/R1.2/cfssl_linux-amd64  
wget -P /usr/local/bin/ -O "cfssljson" https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64  
wget -P /usr/local/bin/ -O "cfssl-certinfo" https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64  
chmod +x /usr/local/bin/*



