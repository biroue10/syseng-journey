# Complete Roadmap — Junior to Senior Systems Engineer
# Based on roadmap.sh/system-engineer + real-world requirements

---

## LEVEL 1 — JUNIOR SYSTEMS ADMINISTRATOR
> Target: Get hired as Junior SysAdmin / Linux Admin
> Duration: 6-12 months

---

### PHASE 1 — Linux Core (Foundation)

#### 1.1 Linux Fundamentals ✅ DONE
- Users & groups: useradd, groupadd, /etc/passwd, /etc/shadow
- Permissions: chmod, chown, ACL, sticky bit, SUID, SGID
- Filesystem hierarchy: FHS, /proc, /sys, /dev
- Package management: dnf, rpm, yum
- systemd: units, targets, services, timers
- Logging: journalctl, /var/log, rsyslog

**Side Project:** Automated user provisioning script
- Bash script that reads a CSV (name, group, ssh_key)
- Creates users, assigns groups, deploys SSH keys, sets password policy
- Sends email report on completion
- Repo: `user-provisioning`

---

#### 1.2 Linux System Internals ✅ DONE
- Boot process: BIOS/UEFI → GRUB → kernel → initramfs → systemd
- Kernel: modules, parameters, sysctl, /proc/sys
- Memory: RAM, swap, OOM killer, huge pages, vmstat
- Processes: fork, exec, signals, namespaces, cgroups
- Storage: block devices, partitions, filesystems (ext4, xfs, btrfs)
- LVM: PV, VG, LV, snapshots, extension à chaud

**Side Project:** System Performance Dashboard
- Bash script collecting CPU, RAM, disk I/O, network stats every 5s
- Writes to CSV, generates HTML report
- Cron-scheduled, keeps 30 days of history
- Repo: `perf-dashboard`

---

#### 1.3 Shell Scripting & Automation
- Bash: variables, arrays, functions, conditionals, loops
- Arguments: $@, getopts, option parsing
- Error handling: set -euo pipefail, trap, exit codes
- Text processing: grep, sed, awk, cut, sort, uniq
- Regular expressions
- Here-docs, process substitution
- Python basics for sysadmin: os, sys, subprocess, pathlib, requests

**Side Project:** Server Audit Tool
- Script that audits a RHEL server: open ports, failed logins, disk usage, outdated packages, sudoers changes
- Generates a color-coded HTML report
- Sends email alert if critical issues found
- Repo: `server-audit`

---

### PHASE 2 — Networking

#### 2.1 Networking Fundamentals
- OSI model: each layer, associated tools
- IP addressing: subnets, CIDR, VLSM, supernetting
- Routing: static routes, routing tables, ip route
- TCP/UDP: ports, states, 3-way handshake, TIME_WAIT
- DNS: recursive vs authoritative, query types, TTL
- DHCP: DORA process, leases, reservations
- NAT: SNAT, DNAT, masquerade
- Switching: VLANs, trunking, STP basics

**Side Project:** Network Documentation Tool
- Script that maps your local network: ARP scan, hostname resolution, open ports per host
- Generates network topology in text + HTML
- Scheduled weekly, diffs against previous scan to detect changes
- Repo: `net-mapper`

---

#### 2.2 Network Services
- DNS server: BIND (authoritative), Unbound (recursive/cache)
- DHCP server: ISC DHCP, reservations by MAC
- NTP: chrony, time synchronization, stratum
- Load balancing: Nginx upstream, HAProxy basics
- Proxy: forward proxy, reverse proxy, Squid

**Side Project:** Home Lab DNS + DHCP Server
- Unbound for local DNS resolution with custom records
- ISC DHCP for static reservations
- Pi-hole style ad blocking via DNS
- Monitoring via Prometheus exporters
- Repo: `homelab-dns`

---

#### 2.3 Network Security & Troubleshooting
- Firewall: firewalld, nftables, iptables
- tcpdump: capture, filter, analyze
- Wireshark: .pcap analysis, protocol decoding
- nmap: host discovery, port scanning, OS detection
- VPN: WireGuard, OpenVPN, tunnel setup
- Troubleshooting methodology: ping → traceroute → mtr → tcpdump → Wireshark

**Side Project:** Intrusion Detection Monitor
- tcpdump-based script monitoring for port scans, brute force, unusual traffic patterns
- Integrates with Fail2ban for automated blocking
- Logs to syslog + sends alerts
- Repo: `ids-monitor`

---

### PHASE 3 — Web & Application Stack

#### 3.1 Web Servers ✅ DONE
- Nginx: config, vhosts, location blocks, upstream
- Apache: .htaccess, mod_rewrite, virtual hosts
- SSL/TLS: certificates, Let's Encrypt, cipher suites, HSTS
- Reverse proxy: proxy_pass, headers, buffering
- Load balancing: round-robin, least_conn, ip_hash

**Side Project:** Multi-tenant Web Platform
- Nginx serving 3 different domains from one server
- Each domain: static site + PHP app + SSL
- Automated Let's Encrypt renewal via certbot
- Custom error pages, access logs per domain
- Repo: `multi-tenant-nginx`

---

#### 3.2 Databases ✅ DONE (MariaDB)
- MariaDB/MySQL: installation, users, privileges, GRANT
- SQL: SELECT, JOIN, INDEX, EXPLAIN, transactions
- Backup: mysqldump, xtrabackup, PITR
- Replication: master/slave, binlog, GTID
- Performance: slow query log, query optimization, connection pooling
- PostgreSQL: installation, pg_hba.conf, roles, pg_dump

**Side Project:** Database Backup & Monitoring System
- Automated backup: mysqldump + compression + encryption (GPG)
- Backup verification: restore to temp DB and run integrity check
- Prometheus exporter for DB metrics (connections, queries/s, replication lag)
- Grafana dashboard + alerting
- Repo: `db-backup-monitor`

---

#### 3.3 Application Runtimes
- PHP-FPM: pools, socket, OpCache, slow log
- Node.js: PM2 process manager, clustering
- Python WSGI: Gunicorn, uWSGI, virtualenv
- Java: JVM tuning, heap size, GC logs
- Application deployment: blue/green, rolling, canary concepts

**Side Project:** Full LEMP Application Stack
- Nginx + PHP-FPM + MariaDB + Redis
- Deploy WordPress + custom PHP app
- Automated deployment script
- Health checks + Prometheus monitoring
- Repo: `lemp-production`

---

### PHASE 4 — Security

#### 4.1 System Security ✅ DONE (mostly)
- SSH hardening: key auth, PermitRootLogin, AllowUsers, 2FA
- SELinux: modes, contexts, booleans, audit2allow
- Fail2ban: jails, actions, backends
- auditd: rules, ausearch, aureport
- OpenSCAP: CIS benchmark, STIG, remediation
- PAM: authentication, password policy, limits

**Side Project:** Security Hardening Playbook
- Ansible playbook implementing CIS Benchmark Level 1 for RHEL
- Automated OpenSCAP scan before and after
- HTML compliance report comparing before/after score
- Repo: `cis-hardening`

---

#### 4.2 PKI & Certificates
- X.509 certificates: structure, chain of trust, SAN
- OpenSSL: generate keys, CSR, sign, verify
- Let's Encrypt: certbot, DNS-01, HTTP-01 challenges, auto-renewal
- Internal CA: create your own CA, sign internal certificates
- Certificate monitoring: expiry alerts

**Side Project:** Internal PKI
- Create a 3-tier CA (Root → Intermediate → Leaf)
- Issue certificates for internal services (Nginx, Prometheus, Grafana)
- Script to check all certs expiry and alert 30 days before
- Repo: `internal-pki`

---

#### 4.3 Vulnerability Management
- CVE tracking: NVD, Red Hat CVE database
- Patch management: dnf-automatic, security-only updates
- Vulnerability scanning: OpenSCAP, Lynis, Trivy
- OWASP Top 10 basics: understanding common web vulnerabilities
- Secrets management: no plaintext passwords in code/config

**Side Project:** Patch Management System
- Script scanning all servers for available security updates
- Generates priority report (critical/important/moderate)
- Automated patching with maintenance window detection
- Post-patch verification: service health check
- Repo: `patch-manager`

---

### PHASE 5 — Monitoring & Observability

#### 5.1 Metrics ✅ DONE
- Prometheus: scraping, metrics types (counter, gauge, histogram)
- Node Exporter: system metrics
- Grafana: dashboards, panels, variables, annotations
- Alertmanager: routes, receivers, inhibitions, silences
- PromQL: queries, aggregations, rate(), irate()

**Side Project:** Production Monitoring Stack
- Full Prometheus + Grafana + Alertmanager setup
- Dashboards: system overview, Nginx, MariaDB, custom app
- Alerts: CPU >80%, disk >85%, service down, cert expiry
- PagerDuty/email/Slack notifications
- Repo: `monitoring-stack`

---

#### 5.2 Log Management
- Centralized logging: rsyslog, syslog-ng
- Loki + Promtail: log aggregation in Grafana
- ELK stack basics: Elasticsearch, Logstash, Kibana
- Log parsing: patterns, filters, structured logging
- Alerting on logs: error rate, specific patterns

**Side Project:** Centralized Log Platform
- Loki + Promtail collecting logs from all servers
- Grafana dashboards: log explorer, error rate trends
- Alerts on ERROR patterns in application logs
- Log retention policy: 90 days hot, archive after
- Repo: `log-platform`

---

#### 5.3 Tracing & APM basics
- Distributed tracing concepts: spans, traces, context propagation
- Jaeger or Zipkin: basic setup
- Application performance monitoring basics
- Golden signals: latency, traffic, errors, saturation

---

### PHASE 6 — Automation & IaC

#### 6.1 Ansible ✅ DONE
- Inventory, playbooks, roles, variables
- Handlers, templates (Jinja2), Vault
- Tags, conditionals, loops
- Dynamic inventory
- Ansible Galaxy: using and publishing roles

**Side Project:** Full Infrastructure Automation
- Ansible roles: base server, Nginx, MariaDB, monitoring, security
- Deploy complete LEMP stack from zero in one command
- Idempotent: running twice changes nothing
- CI validation with ansible-lint
- Repo: `ansible-lemp-stack` ✅ DONE

---

#### 6.2 Git & CI/CD
- Git: branches, merge, rebase, cherry-pick, stash
- GitFlow vs trunk-based development
- GitHub Actions: workflows, jobs, steps, secrets
- CI pipeline: lint → test → build → deploy
- Deployment strategies: blue/green, rolling, canary
- Infrastructure testing: Molecule for Ansible, Testinfra

**Side Project:** Automated Deployment Pipeline
- GitHub Actions pipeline for a PHP application
- Steps: syntax check → Ansible lint → deploy to staging → smoke test → deploy to prod
- Rollback on failure: revert to previous release
- Slack notification on deploy success/failure
- Repo: `deploy-pipeline`

---

#### 6.3 Terraform
- Concepts: providers, resources, state, plan, apply, destroy
- Variables, outputs, locals, data sources
- Modules: write reusable modules
- Remote state: S3 backend, state locking
- Workspaces: dev/staging/prod environments
- Terragrunt: DRY Terraform configurations

**Side Project:** Infrastructure as Code — Complete Lab
- Terraform provisioning: VMs, networks, firewall rules, DNS records
- Modules: vm, network, security_group
- 3 environments: dev, staging, prod
- State in remote backend with locking
- Repo: `terraform-lab`

---

### PHASE 7 — Containers

#### 7.1 Docker 🔄 IN PROGRESS
- Images: layers, Dockerfile, build cache, multi-stage builds
- Containers: lifecycle, networking, volumes, env vars
- Docker Compose: multi-service, depends_on, healthcheck
- Registry: Docker Hub, private registry (Harbor)
- Security: non-root user, read-only filesystem, image scanning

**Side Project:** Containerized LEMP Stack
- Dockerfile for custom PHP-FPM image
- docker-compose: Nginx + PHP-FPM + MariaDB + Redis
- Persistent volumes for DB data and uploads
- Health checks on all services
- Non-root users in all containers
- Repo: `docker-lemp`

---

#### 7.2 Container Security & Best Practices
- Image scanning: Trivy, Snyk, Docker Scout
- Distroless images: minimize attack surface
- Secrets in containers: env vars vs Docker secrets vs Vault
- Runtime security: Falco, seccomp, AppArmor profiles
- Image signing: Cosign, notation

**Side Project:** Secure Container Pipeline
- GitHub Actions: build → scan with Trivy → fail if CRITICAL CVE → push to registry
- Base images: alpine/distroless
- Automated image updates with Dependabot
- Repo: `secure-containers`

---

## LEVEL 2 — SYSTEMS ADMINISTRATOR
> Target: Get promoted or hired as SysAdmin
> Duration: 12-18 months after Level 1

---

### PHASE 8 — Kubernetes

#### 8.1 Kubernetes Fundamentals
- Architecture: control plane (API server, etcd, scheduler, controller), nodes, kubelet
- Core objects: Pod, Deployment, Service, ConfigMap, Secret, Namespace
- kubectl: get, describe, logs, exec, apply, delete
- Networking: Services (ClusterIP, NodePort, LoadBalancer), Ingress
- Storage: PV, PVC, StorageClass, dynamic provisioning
- RBAC: Roles, ClusterRoles, RoleBindings

**Side Project:** Deploy LEMP Stack on Kubernetes
- Nginx Deployment + Service + Ingress
- PHP-FPM Deployment
- MariaDB StatefulSet with PVC
- ConfigMaps for Nginx config, Secrets for DB passwords
- Horizontal Pod Autoscaler for PHP
- Repo: `k8s-lemp`

---

#### 8.2 Kubernetes Operations
- Rolling updates and rollbacks
- Resource limits and requests, LimitRange, ResourceQuota
- Liveness and readiness probes
- Pod disruption budgets, priority classes
- Node management: taints, tolerations, affinity, node selectors
- Cluster upgrades: control plane then workers

**Side Project:** Production-ready Kubernetes Cluster
- k3s cluster: 1 master + 2 workers on RHEL VMs
- MetalLB: bare metal load balancer
- Cert-manager: automatic TLS
- Longhorn: distributed storage
- Repo: `k3s-cluster`

---

#### 8.3 Helm & Package Management
- Helm charts: templates, values, helpers
- Install, upgrade, rollback, uninstall
- Create your own chart
- Helm repositories: ArtifactHub, private registry
- Helmfile: manage multiple releases declaratively

**Side Project:** Helm Chart Library
- Charts for: Nginx app, MariaDB, monitoring stack, ingress
- Published to GitHub Pages as Helm repository
- CI/CD: helm lint + helm test on PR
- Repo: `helm-charts`

---

#### 8.4 Kubernetes Monitoring & Security
- kube-state-metrics, metrics-server
- Prometheus Operator: CRDs, ServiceMonitor, PodMonitor
- Grafana dashboards for K8s: cluster, node, pod, namespace
- Network policies: micro-segmentation between pods
- Pod Security Standards: restricted, baseline, privileged
- OPA/Gatekeeper: policy enforcement

**Side Project:** K8s Observability Stack
- Prometheus Operator + kube-state-metrics + node-exporter
- Grafana dashboards: cluster overview, workload details
- Alerting: pod crash loop, node not ready, high memory
- Loki for log aggregation from all pods
- Repo: `k8s-monitoring`

---

### PHASE 9 — High Availability & Resilience

#### 9.1 High Availability ✅ DONE (partial)
- Load balancing: Nginx, HAProxy — algorithms, health checks, SSL termination
- Database HA: MariaDB replication (master/slave, GTID), Galera Cluster
- Keepalived: VRRP, virtual IP failover
- Service mesh basics: Istio, Linkerd concepts
- Geographic redundancy: DNS failover, anycast

**Side Project:** Full HA Lab
- 2 web servers behind HAProxy with health checks
- MariaDB master + slave with automatic failover (MHA or orchestrator)
- Keepalived VIP floating between HAProxy nodes
- Chaos testing: kill one node, verify zero downtime
- Repo: `ha-lab`

---

#### 9.2 Backup & Disaster Recovery
- Backup strategies: full, incremental, differential
- 3-2-1 rule implementation
- rsync: local and remote sync, SSH, checksums
- Bacula/Amanda: enterprise backup solutions
- Database backup: mysqldump, xtrabackup, pg_basebackup
- PITR: Point-in-Time Recovery for databases
- DR testing: quarterly restore tests, documented RTO/RPO
- Offsite backup: S3, Backblaze B2, rclone

**Side Project:** Enterprise Backup System
- rsync-based incremental backup for files
- xtrabackup for hot MariaDB backup
- Encrypted backups with GPG
- Offsite sync to S3 with rclone
- Monthly restore test with automated verification
- Grafana dashboard: backup status, size, duration
- Repo: `backup-system`

---

#### 9.3 Chaos Engineering
- Chaos principles: inject failure to find weakness
- Chaos Monkey: random instance termination
- Chaos Toolkit: structured chaos experiments
- Failure modes: network partition, disk full, high latency, resource exhaustion
- Game days: planned chaos exercises with the team

**Side Project:** Chaos Testing Framework
- Scripts simulating: disk full, CPU saturation, network partition, service crash
- Automated recovery verification after each failure
- Report: MTTR per failure scenario
- Repo: `chaos-lab`

---

### PHASE 10 — Cloud

#### 10.1 AWS Core Services
- Compute: EC2, Auto Scaling Groups, Launch Templates
- Storage: S3, EBS, EFS, Glacier
- Networking: VPC, subnets, route tables, NAT gateway, security groups, NACLs
- DNS: Route53, hosted zones, health checks, routing policies
- IAM: users, roles, policies, least privilege, MFA
- Database: RDS, Aurora, ElastiCache

**Side Project:** AWS Infrastructure Deployment
- VPC with public/private subnets in 2 AZs
- EC2 Auto Scaling Group behind ALB
- RDS MariaDB in private subnet with Multi-AZ
- S3 for static assets + CloudFront CDN
- Route53 with health checks and failover
- All provisioned with Terraform
- Repo: `aws-infrastructure`

---

#### 10.2 AWS Operations
- CloudWatch: metrics, logs, alarms, dashboards
- CloudTrail: API audit log
- Systems Manager: Parameter Store, Session Manager, Patch Manager
- Cost optimization: Reserved Instances, Spot, rightsizing
- Security: AWS Config, GuardDuty, Security Hub, WAF
- Tagging strategy: mandatory tags for cost allocation

**Side Project:** AWS Cost & Security Monitor
- Lambda function checking for untagged resources
- CloudWatch alarms for budget thresholds
- GuardDuty findings → SNS → Slack
- Weekly cost report sent by email
- Repo: `aws-governance`

---

#### 10.3 Multi-Cloud & Cloud Native
- GCP basics: GCE, GKE, Cloud Storage, Cloud SQL
- Azure basics: VMs, AKS, Blob Storage, Azure AD
- Cloud native concepts: 12-factor app, immutable infrastructure
- Container registries: ECR, GCR, ACR

---

### PHASE 11 — Advanced Automation

#### 11.1 GitOps
- GitOps principles: Git as single source of truth
- ArgoCD: installation, applications, sync policies, RBAC
- Flux: alternative GitOps operator
- Drift detection: alert when cluster diverges from Git
- Secrets in GitOps: Sealed Secrets, External Secrets Operator

**Side Project:** GitOps-driven Kubernetes
- ArgoCD managing all K8s applications
- App-of-apps pattern: one ArgoCD app managing all others
- Automated sync: every Git push deploys to staging
- Manual approval gate for production
- Repo: `gitops-lab`

---

#### 11.2 HashiCorp Vault
- Secrets engines: KV v2, PKI, database, AWS
- Auth methods: AppRole, Kubernetes, AWS IAM
- Dynamic credentials: Vault generates DB users on-demand
- PKI: Vault as internal CA for all TLS certificates
- Audit log: every secret access logged

**Side Project:** Secrets Management Platform
- Vault HA cluster (3 nodes with Raft storage)
- Dynamic MariaDB credentials: app gets temp user, auto-revoked after 1h
- Vault as internal CA: all services use Vault-issued certs
- Kubernetes integration: pods get secrets via Vault Agent
- Repo: `vault-platform`

---

#### 11.3 Advanced Ansible
- Dynamic inventory: AWS EC2, Azure, GCP
- Custom modules: write a Python Ansible module
- Callback plugins: custom output, notifications
- Strategy plugins: linear, free, debug
- Performance: pipelining, forks, async tasks
- Testing: Molecule + Docker driver + Testinfra assertions

**Side Project:** Ansible Platform
- AWX (open source Ansible Tower) deployment
- Inventory synced from AWS/GCP automatically
- Role-based access: teams manage only their playbooks
- Approval workflow for production changes
- Repo: `ansible-platform`

---

## LEVEL 3 — SENIOR SYSTEMS ENGINEER
> Target: Senior SysEng / Staff Engineer / SRE
> Duration: 2-4 years total experience

---

### PHASE 12 — SRE & Reliability Engineering

#### 12.1 SRE Fundamentals
- SLI / SLO / SLA: define and measure reliability
- Error budget: how much downtime is acceptable
- Toil: identify and reduce repetitive manual work
- Capacity planning: predict resource needs before saturation
- On-call: rotation, escalation, blameless post-mortems
- Incident management: severity levels, communication, war room

**Side Project:** SRE Dashboard
- SLO tracking for all services (availability, latency, error rate)
- Error budget burn rate alerts
- Toil tracker: hours spent on manual tasks per week
- Post-mortem database with lessons learned
- Repo: `sre-platform`

---

#### 12.2 Advanced Observability
- Four Golden Signals: latency, traffic, errors, saturation
- Distributed tracing: Jaeger, Tempo
- Continuous profiling: Pyroscope, Parca
- Synthetic monitoring: Blackbox Exporter, Uptime Kuma
- OpenTelemetry: unified observability standard

**Side Project:** Full Observability Platform
- Metrics: Prometheus + Thanos (long-term storage)
- Logs: Loki + Grafana
- Traces: Tempo + Grafana
- Profiles: Pyroscope
- All connected in Grafana with correlation
- Repo: `observability-platform`

---

#### 12.3 Performance Engineering
- Profiling: CPU, memory, I/O, network
- Benchmarking: wrk, ab, k6 for load testing
- Database tuning: query optimization, indexing, connection pooling
- Kernel tuning: sysctl, network stack, I/O scheduler
- Linux perf tools: perf, flamegraphs, bpftrace, eBPF

**Side Project:** Performance Testing Framework
- k6 load tests for all APIs
- Baseline + regression tests in CI
- Automated flamegraph generation on performance regression
- Grafana dashboard comparing performance across releases
- Repo: `perf-testing`

---

### PHASE 13 — Advanced Security

#### 13.1 Zero Trust Architecture
- Principles: never trust, always verify, least privilege
- Identity: strong authentication, MFA everywhere, SSO (Keycloak, Okta)
- Network: micro-segmentation, service mesh mTLS (Istio)
- Endpoint: device trust, certificate-based auth
- Secrets: Vault for all credentials, no long-lived tokens

**Side Project:** Zero Trust Lab
- Keycloak as IdP: SSO for all internal services
- mTLS between all services via Istio
- OPA policies: only authenticated + authorized requests reach services
- All secrets from Vault, no env vars with passwords
- Repo: `zero-trust-lab`

---

#### 13.2 Security Automation & DevSecOps
- Shift-left security: security checks in CI/CD pipeline
- SAST: static analysis (Semgrep, Bandit)
- DAST: dynamic analysis (OWASP ZAP)
- Container scanning: Trivy in CI, continuous scanning in registry
- Infrastructure scanning: Checkov for Terraform, kube-bench for K8s
- Compliance as code: InSpec, OpenSCAP automated

**Side Project:** DevSecOps Pipeline
- GitHub Actions: SAST → container scan → IaC scan → DAST → deploy
- Block merge if CRITICAL vulnerability found
- Weekly full environment scan report
- Compliance dashboard: CIS score over time
- Repo: `devsecops-pipeline`

---

### PHASE 14 — Architecture & Design

#### 14.1 System Design
- Scalability: horizontal vs vertical, stateless design
- Caching: Redis, Memcached, CDN, cache invalidation strategies
- Message queues: RabbitMQ, Kafka — async decoupling
- Microservices: API gateway, service discovery, circuit breaker
- Database patterns: CQRS, event sourcing, sharding, read replicas
- CAP theorem: consistency, availability, partition tolerance trade-offs

**Side Project:** Scalable Web Architecture
- Redis cluster for session storage and caching
- RabbitMQ for async job processing
- Nginx API gateway routing to microservices
- Auto-scaling based on queue depth
- Repo: `scalable-architecture`

---

#### 14.2 Platform Engineering
- Internal Developer Platform (IDP): self-service infrastructure
- Backstage: developer portal
- Golden paths: opinionated, supported ways to deploy
- Environment management: dev/staging/prod consistency
- Cost allocation: showback/chargeback per team

**Side Project:** Internal Developer Platform
- Backstage portal: service catalog, docs, scaffolding templates
- Terraform module library: "one-click" environments
- GitHub Actions templates: standard CI/CD for teams
- Repo: `developer-platform`

---

## CERTIFICATIONS — Official Validation

```
RHCSA (EX200)     →    RHCE (EX294)    →    CKA    →    AWS SAA    →    CKS
  Junior Linux         Ansible/Auto        K8s Admin     Cloud Arch     K8s Security
  6-12 months          +6 months          +6 months      +6 months      +6 months
```

| Certification | Level | Priority | Validates |
|---------------|-------|----------|-----------|
| **RHCSA** | Junior | ⭐⭐⭐⭐⭐ | Linux administration |
| **RHCE** | Mid | ⭐⭐⭐⭐⭐ | Ansible automation |
| **CKA** | Mid-Senior | ⭐⭐⭐⭐⭐ | Kubernetes administration |
| **AWS SAA** | Mid-Senior | ⭐⭐⭐⭐ | Cloud architecture |
| **CKS** | Senior | ⭐⭐⭐⭐ | Kubernetes security |
| **HashiCorp Vault** | Senior | ⭐⭐⭐ | Secrets management |
| **Terraform Associate** | Mid | ⭐⭐⭐⭐ | Infrastructure as Code |

---

## FULL PROGRESSION TABLE

| # | Phase | Module | Level | Side Project | Status |
|---|-------|--------|-------|-------------|--------|
| 01 | Linux Core | Linux Fundamentals | Junior | User Provisioning Script | ✅ |
| 02 | Linux Core | Linux System Internals | Junior | Performance Dashboard | ✅ |
| 03 | Linux Core | Bash Scripting | Junior | Server Audit Tool | ⬜ |
| 04 | Networking | Networking Fundamentals | Junior | Network Mapper | ⬜ |
| 05 | Networking | DNS & DHCP | Junior | Home Lab DNS | ⬜ |
| 06 | Networking | Network Security | Junior | IDS Monitor | ⬜ |
| 07 | Web Stack | Nginx | Junior | Multi-tenant Nginx | ✅ |
| 08 | Web Stack | MariaDB | Junior | DB Backup & Monitor | ✅ |
| 09 | Web Stack | PHP-FPM / LEMP | Junior | WordPress Production | ⬜ |
| 10 | Monitoring | Prometheus + Grafana | Junior | Monitoring Stack | ✅ |
| 11 | Monitoring | Log Management | Junior | Log Platform | ⬜ |
| 12 | Security | System Hardening | Junior | CIS Hardening Playbook | 🔄 |
| 13 | Security | PKI & Certificates | Junior | Internal PKI | ⬜ |
| 14 | Security | Vulnerability Mgmt | Junior | Patch Manager | ⬜ |
| 15 | Automation | Ansible | Junior | LEMP Stack Ansible | ✅ |
| 16 | Automation | Git & CI/CD | Junior | Deploy Pipeline | ⬜ |
| 17 | Automation | Terraform | Mid | IaC Lab | ⬜ |
| 18 | Containers | Docker | Junior | Containerized LEMP | 🔄 |
| 19 | Containers | Container Security | Mid | Secure Container Pipeline | ⬜ |
| 20 | Kubernetes | K8s Fundamentals | Mid | LEMP on K8s | ⬜ |
| 21 | Kubernetes | K8s Operations | Mid | Production K3s Cluster | ⬜ |
| 22 | Kubernetes | Helm | Mid | Helm Chart Library | ⬜ |
| 23 | Kubernetes | K8s Monitoring | Mid | K8s Observability | ⬜ |
| 24 | HA & DR | High Availability | Mid | HA Lab | 🔄 |
| 25 | HA & DR | Backup & DR | Mid | Enterprise Backup | ⬜ |
| 26 | HA & DR | Chaos Engineering | Mid | Chaos Lab | ⬜ |
| 27 | Cloud | AWS Core | Mid | AWS Infrastructure | ⬜ |
| 28 | Cloud | AWS Operations | Mid | AWS Governance | ⬜ |
| 29 | Automation++ | GitOps (ArgoCD) | Senior | GitOps Lab | ⬜ |
| 30 | Automation++ | HashiCorp Vault | Senior | Secrets Platform | ⬜ |
| 31 | Automation++ | Advanced Ansible | Senior | Ansible Platform (AWX) | ⬜ |
| 32 | SRE | SRE Fundamentals | Senior | SRE Dashboard | ⬜ |
| 33 | SRE | Advanced Observability | Senior | Full Observability Stack | ⬜ |
| 34 | SRE | Performance Engineering | Senior | Perf Testing Framework | ⬜ |
| 35 | Security++ | Zero Trust | Senior | Zero Trust Lab | ⬜ |
| 36 | Security++ | DevSecOps | Senior | DevSecOps Pipeline | ⬜ |
| 37 | Architecture | System Design | Senior | Scalable Architecture | ⬜ |
| 38 | Architecture | Platform Engineering | Senior | Developer Platform | ⬜ |

**Legend:** ✅ Done · 🔄 In Progress · ⬜ To Do

---

## Time Estimate

| Level | Modules | Duration (1-2h/day) |
|-------|---------|-------------------|
| Junior SysAdmin | 01-19 | 8-12 months |
| SysAdmin | 20-31 | +12-18 months |
| Senior SysEng | 32-38 | +12-18 months |
| **Total Junior → Senior** | **38 modules** | **3-4 years** |

**The side projects are what get you hired.**
A GitHub with 20 working projects beats a CV with 10 certifications.
