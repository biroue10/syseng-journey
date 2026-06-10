# Prometheus + Node Exporter

## Objectif

Collecter les métriques système (CPU, RAM, disque, réseau) avec Node Exporter et les stocker dans Prometheus pour visualisation et alerting.

## Architecture

```
Serveur RHEL
    │
    ├── Node Exporter :9100  ──► expose les métriques système
    │
    └── Prometheus :9090     ──► scrape Node Exporter toutes les 15s
```

## Installation — Node Exporter

Téléchargement du binaire (version linux-amd64) et installation manuelle :

```bash
tar xvf node_exporter-*.tar.gz
sudo mv node_exporter-*/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter
```

Service systemd `/etc/systemd/system/node_exporter.service` :

```ini
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

## Installation — Prometheus

```bash
tar xvf prometheus-*.tar.gz
sudo mv prometheus-*/prometheus /usr/local/bin/
sudo useradd -rs /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheus
sudo mv prometheus-*/prometheus.yml /etc/prometheus/
```

Service systemd `/etc/systemd/system/prometheus.service` :

```ini
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
```

## Configuration — /etc/prometheus/prometheus.yml

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]
```

## Vérification

```bash
curl -s http://localhost:9090/api/v1/targets | grep health
```

Résultat attendu : 2x `"health":"up"` (prometheus + node_exporter).

## Ports ouverts

```bash
sudo firewall-cmd --add-port=9090/tcp --permanent
sudo firewall-cmd --add-port=9100/tcp --permanent
sudo firewall-cmd --reload
```

## Ce que j'ai appris

- Un binaire Linux s'installe dans `/usr/local/bin/` et tourne comme service systemd sous un utilisateur dédié sans shell (`-rs /bin/false`)
- Prometheus scrape les targets définies dans `prometheus.yml` à intervalle régulier
- YAML est sensible à l'indentation — une erreur de 2 espaces casse toute la config
- Toujours vérifier `linux-amd64` et non `darwin-amd64` lors du téléchargement
