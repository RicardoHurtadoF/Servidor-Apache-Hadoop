#!/bin/bash

# =========================
# CONFIGURACIÓN
# =========================
HADOOP_VERSION=3.3.6
HADOOP_USER=hadoop
MASTER_HOST=master

# =========================
# ACTUALIZAR E INSTALAR
# =========================
sudo apt update -y
sudo apt install -y openjdk-8-jdk ssh rsync wget

# =========================
# CREAR USUARIO HADOOP
# =========================
if ! id "$HADOOP_USER" &>/dev/null; then
    sudo adduser --disabled-password --gecos "" $HADOOP_USER
    sudo usermod -aG sudo $HADOOP_USER
fi

# =========================
# CAMBIAR A USUARIO HADOOP
# =========================
sudo -i -u $HADOOP_USER bash << EOF

# =========================
# DESCARGAR HADOOP
# =========================
cd ~
if [ ! -d "hadoop" ]; then
    wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
    tar -xzf hadoop-$HADOOP_VERSION.tar.gz
    mv hadoop-$HADOOP_VERSION hadoop
fi

# =========================
# VARIABLES DE ENTORNO
# =========================
if ! grep -q "HADOOP_HOME" ~/.bashrc; then
cat <<EOT >> ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=~/hadoop
export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin
EOT
fi

source ~/.bashrc

# =========================
# CONFIGURAR HADOOP
# =========================

HADOOP_CONF=~/hadoop/etc/hadoop

# core-site.xml
cat <<EOT > \$HADOOP_CONF/core-site.xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://$MASTER_HOST:9000</value>
  </property>
</configuration>
EOT

# hdfs-site.xml
cat <<EOT > \$HADOOP_CONF/hdfs-site.xml
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
</configuration>
EOT

# yarn-site.xml
cat <<EOT > \$HADOOP_CONF/yarn-site.xml
<configuration>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>$MASTER_HOST</value>
  </property>
</configuration>
EOT

# workers
cat <<EOT > \$HADOOP_CONF/workers
worker1
worker2
EOT

EOF

echo "Instalación base completada"
