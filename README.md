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
