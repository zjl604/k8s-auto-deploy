# 注意此脚本需要登录到 etcd03 去执行
# etcd03
# 创建 etcd 启动的配置文件
cat <<EOF >/opt/kubernetes/cfg/etcd
#[Member]
ETCD_NAME="etcd03"
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="https://172.16.18.4:2380"
ETCD_LISTEN_CLIENT_URLS="https://172.16.18.4:2379"
#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://172.16.18.4:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://172.16.18.4:2379"
ETCD_INITIAL_CLUSTER="etcd01=https://172.16.18.2:2380,etcd02=https://172.16.18.3:2380,etcd03=https://172.16.18.4:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"
EOF

# 创建 etcd 自启动文件
cat <<"EOF" >/usr/lib/systemd/system/etcd.service
[Unit]
Description=EtcdServer
After=network.target
After=network-online.target
Wants=network-online.target
[Service]
Type=notify
EnvironmentFile=-/opt/kubernetes/cfg/etcd
ExecStart=/opt/kubernetes/bin/etcd \
--name=${ETCD_NAME} \
--data-dir=${ETCD_DATA_DIR} \
--listen-peer-urls=${ETCD_LISTEN_PEER_URLS} \
--listen-client-urls=${ETCD_LISTEN_CLIENT_URLS},http://127.0.0.1:2379 \
--advertise-client-urls=${ETCD_ADVERTISE_CLIENT_URLS} \
--initial-advertise-peer-urls=${ETCD_INITIAL_ADVERTISE_PEER_URLS} \
--initial-cluster=${ETCD_INITIAL_CLUSTER} \
--initial-cluster-token=${ETCD_INITIAL_CLUSTER} \
--initial-cluster-state=new \
--cert-file=/opt/kubernetes/ssl/server.pem \
--key-file=/opt/kubernetes/ssl/server-key.pem \
--peer-cert-file=/opt/kubernetes/ssl/server.pem \
--peer-key-file=/opt/kubernetes/ssl/server-key.pem \
--trusted-ca-file=/opt/kubernetes/ssl/ca.pem \
--peer-trusted-ca-file=/opt/kubernetes/ssl/ca.pem
Restart=on-failure
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF
