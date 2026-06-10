# Grafana

## Objectif

Visualiser les métriques Prometheus via des dashboards interactifs.

## Installation

Grafana est disponible dans les repos RHEL 10 :

```bash
sudo dnf install grafana -y
sudo systemctl enable --now grafana-server
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload
```

Interface accessible sur : `http://<IP>:3000`  
Identifiants par défaut : `admin` / `admin`

## Connexion à Prometheus (datasource)

**Connections → Data sources → Add data source → Prometheus**

URL : `http://localhost:9090`

### Problème SELinux

SELinux bloque Grafana par défaut sur le port 9090 :

```
avc: denied { name_connect } for comm="grafana" dest=9090
scontext=grafana_t  tcontext=websm_port_t
```

Diagnostic et correction :

```bash
sudo ausearch -m avc -ts recent | audit2allow -m grafana_prometheus
sudo setsebool -P grafana_can_tcp_connect_prometheus_port=on
```

## Dashboard Node Exporter Overview

Métriques configurées :

| Panel | Query PromQL |
|-------|-------------|
| CPU Usage % | `100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)` |
| RAM disponible | `node_memory_MemAvailable_bytes` |
| Disque utilisé % | `100 - ((node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100)` |

## Ce que j'ai appris

- Grafana tourne sur le port 3000, service `grafana-server` (pas `grafana`)
- SELinux a un boolean dédié `grafana_can_tcp_connect_prometheus_port` — toujours diagnostiquer avec `ausearch` avant de chercher ailleurs
- `audit2allow` suggère automatiquement la correction SELinux adaptée
- PromQL : `rate()` calcule un taux par seconde sur une fenêtre de temps, `avg()` agrège sur tous les CPU
