# Instalación de Clúster con Apache Hadoop (3 Nodos)

Este proyecto automatiza la instalación y configuración de un clúster básico de Apache Hadoop utilizando 3 máquinas virtuales Linux.

---

## Arquitectura del clúster

- **master**
  - NameNode
  - ResourceManager

- **worker1**
  - DataNode
  - NodeManager

- **worker2**
  - DataNode
  - NodeManager

---

## Requisitos

- 3 máquinas Linux (Ubuntu/Debian)
- Conectividad entre nodos (misma red)
- Acceso sudo
- Nombres de host definidos como:
  - `master`
  - `worker1`
  - `worker2`

---

## 1. Configuración de red

Editar `/etc/hosts` en TODAS las máquinas:

```bash
ip1 master
ip2 worker1
ip3 worker2
```

Verificar conexión:
```bash
ping master
ping worker1
ping worker2
```
2. Instalación automática

En cada máquina:
```bash
chmod +x setup_hadoop.sh
./setup_hadoop.sh
```
Este script realiza:

Instalación de Java
Creación del usuario hadoop
Descarga de Hadoop
Configuración básica del sistema
3. Configuración del nodo maestro

En la máquina master:
```bash
chmod +x setup_master.sh
./setup_master.sh
```
Este script:

Configura SSH sin contraseña
Copia Hadoop a los workers
Formatea HDFS
Inicia el clúster
4. Verificación

Ejecutar en el master:
```bash
jps
```
Procesos esperados:

NameNode
DataNode
ResourceManager
NodeManager

5. Interfaces web
   
HDFS: http://master:9870
YARN: http://master:8088

7. Prueba básica
   
```bash
hdfs dfs -mkdir /test
hdfs dfs -put archivo.txt /test
hdfs dfs -ls /test
