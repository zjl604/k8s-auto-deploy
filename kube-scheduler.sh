cat <<EOF >/opt/kubernetes/cfg/kube-scheduler

KUBE_SCHEDULER_OPTS="--logtostderr=true \\
--address=0.0.0.0 \\
--master=http://127.0.0.1:8080 \\
--leader-elect=true \\
--v=4"
EOF
