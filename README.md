# 🧩 Multi-Container Microservices — Docker Compose

A full multi-tier containerized microservices architecture using Docker Compose — orchestrating frontend, backend API, PostgreSQL database, Redis cache, and Nginx reverse proxy on AWS EC2.

## 📌 Project Overview

Demonstrates container-based microservices design with isolated, scalable services connected through Docker networks. Each service runs independently and communicates via service discovery.

## 🏗️ Architecture

```
Internet
   ↓
[ Nginx :80 ]  ←─ Reverse Proxy
   ├──→ [ Frontend :3000 ]  (React/Node)
   └──→ [ Backend  :5000 ]  (Node.js API)
              ├──→ [ Database :5432 ]  (PostgreSQL)
              └──→ [ Cache    :6379 ]  (Redis)

Networks:
  frontend-network: nginx ↔ frontend ↔ backend
  backend-network:  backend ↔ database ↔ cache
```

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Docker Compose | Multi-container orchestration |
| Nginx | Reverse proxy + load balancer |
| Node.js | Frontend & Backend services |
| PostgreSQL | Relational database |
| Redis | Caching layer |
| AWS EC2 | Hosting |
| Shell Scripting | Stack management |

## 📁 Project Structure

```
5-microservices-compose/
├── docker-compose.yml          # Full stack definition
├── nginx/
│   └── nginx.conf              # Reverse proxy config
├── frontend/
│   └── Dockerfile              # Frontend container
├── backend/
│   └── Dockerfile              # Backend API container
├── database/
│   └── init.sql                # DB schema + seed data
├── scripts/
│   └── manage.sh               # Start/stop/status script
└── README.md
```

## ⚙️ Setup Instructions

### Step 1 — Clone & Start
```bash
git clone https://github.com/<your-username>/5-microservices-compose.git
cd 5-microservices-compose

# Start full stack
chmod +x scripts/manage.sh
./scripts/manage.sh start
```

### Step 2 — Access Services
```
Frontend App:  http://<EC2-IP>
Backend API:   http://<EC2-IP>/api
```

### Step 3 — Manage the Stack
```bash
./scripts/manage.sh status     # View container status + resource usage
./scripts/manage.sh logs       # View all logs
./scripts/manage.sh logs backend   # View specific service logs
./scripts/manage.sh restart    # Restart stack
./scripts/manage.sh stop       # Stop stack
./scripts/manage.sh clean      # Remove everything including volumes
```

## 🔧 Useful Docker Compose Commands

```bash
# Start in background
docker-compose up -d

# Rebuild images
docker-compose up -d --build

# View running services
docker-compose ps

# Scale a service
docker-compose up -d --scale backend=3

# Execute command in container
docker-compose exec backend sh

# View logs live
docker-compose logs -f backend

# Stop and remove volumes
docker-compose down -v
```

## 🌐 Service Discovery

Docker Compose automatically creates DNS-based service discovery. Services communicate using their **service names** as hostnames:

| From | To | Hostname |
|------|----|----------|
| Backend | Database | `database` |
| Backend | Redis | `cache` |
| Nginx | Frontend | `frontend` |
| Nginx | Backend | `backend` |

## 📊 Results

- ✅ 5 isolated services with independent scaling
- ✅ Dual network isolation (frontend/backend separation)
- ✅ Health checks on all containers
- ✅ Persistent volumes for database and cache
- ✅ Nginx reverse proxy with path-based routing
- ✅ Single command deployment with `docker-compose up`
