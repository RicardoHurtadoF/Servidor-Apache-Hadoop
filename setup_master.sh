#!/bin/bash

HADOOP_USER=hadoop

sudo -i -u $HADOOP_USER bash << EOF

# =========================
# SSH SIN PASSWORD
# =========================
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
fi

ssh-copy-id $HADOOP_USER@worker1
ssh-copy-id $HADOOP_USER@worker2
ssh-copy-id $HADOOP_USER@master

# =========================
# COPIAR HADOOP A WORKERS
# =========================
scp -r ~/hadoop $HADOOP_USER@worker1:~
scp -r ~/hadoop $HADOOP_USER@worker2:~

# =========================
# FORMATEAR HDFS
# =========================
hdfs namenode -format

# =========================
# INICIAR CLUSTER
# =========================
start-dfs.sh
start-yarn.sh

EOF

echo "Cluster iniciado"
