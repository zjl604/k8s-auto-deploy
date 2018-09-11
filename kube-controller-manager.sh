cat <<EOF >/opt/kubernetes/cfg/kube-controller-manager

KUBE_CONTROLLER_MANAGER_OPTS="--logtostderr=true \\
--address=0.0.0.0 \\
--master=http://127.0.0.1:8080 \\
--allocate-node-cidrs=true \\
--service-cluster-ip-range=10.10.10.0/24 \\
--cluster-cidr=10.10.10.0/24 \\
--cluster-signing-cert-file=/opt/kubernetes/ssl/ca.pem \\
--cluster-signing-key-file=/opt/kubernetes/ssl/ca-key.pem \\
--feature-gates=RotateKubeletServerCertificate=true \\
--controllers=*,tokencleaner,bootstrapsigner \\
--experimental-cluster-signing-duration=86700h0m0s \\
--cluster-name=kubernetes \\
--service-account-private-key-file=/opt/kubernetes/ssl/ca-key.pem \\
--root-ca-file=/opt/kubernetes/ssl/ca.pem \\
--leader-elect=true \\
--node-monitor-grace-period=40s \\
--node-monitor-period=5s \\
--pod-eviction-timeout=5m0s \\
--v=4"
EOF
