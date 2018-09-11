cat <<EOF >/opt/kubernetes/cfg/kube-apiserver

KUBE_APISERVER_OPTS="--logtostderr=true \\
--admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota,NodeRestriction \\
--anonymous-auth=false \\
--experimental-encryption-provider-config=/opt/kubernetes/cfg/encryption-config.yaml \\
--advertise-address=172.16.18.2 \\
--allow-privileged=true \\
--apiserver-count=3 \\
--audit-policy-file=/opt/kubernetes/cfg/audit-policy.yaml \\
--audit-log-maxage=30 \\
--audit-log-maxbackup=3 \\
--audit-log-maxsize=100 \\
--audit-log-path=/opt/kubernetes/logs/audit.log \\
--authorization-mode=Node,RBAC \\
--bind-address=0.0.0.0 \\
--secure-port=6443 \\
--client-ca-file=/opt/kubernetes/ssl/ca.pem \\
--kubelet-client-certificate=/opt/kubernetes/ssl/server.pem \\
--kubelet-client-key=/opt/kubernetes/ssl/server-key.pem \\
--enable-swagger-ui=true \\
--etcd-cafile=/opt/kubernetes/ssl/ca.pem \\
--etcd-certfile=/opt/kubernetes/ssl/server.pem \\
--etcd-keyfile=/opt/kubernetes/ssl/server-key.pem \\
--etcd-servers=https://172.16.18.2:2379,https://172.16.18.3:2379,https://172.16.18.4:2379 \\
--event-ttl=1h \\
--kubelet-https=true \\
--insecure-bind-address=127.0.0.1 \\
--insecure-port=8080 \\
--service-account-key-file=/opt/kubernetes/ssl/ca-key.pem \\
--service-cluster-ip-range=10.10.10.0/24 \\
--service-node-port-range=30000-50000 \\
--tls-cert-file=/opt/kubernetes/ssl/server.pem  \\
--tls-private-key-file=/opt/kubernetes/ssl/server-key.pem \\
--enable-bootstrap-token-auth \\
--v=4"
EOF
