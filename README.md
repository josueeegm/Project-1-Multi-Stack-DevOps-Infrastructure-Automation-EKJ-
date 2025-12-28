Voting App on Amazon EKS

A production-like 3-tier microservices application deployed on Amazon EKS (Kubernetes) with a fully automated CI/CD pipeline using GitHub Actions.

🚀 Features
✅ Polyglot microservices architecture (Python, Node.js, .NET)
🐳 All services containerized with Docker
☸️ Deployed on Amazon EKS using Kubernetes manifests
🔁 Asynchronous vote processing via Redis and background worker
📊 Persistent storage with PostgreSQL
🌐 External access managed through NGINX Ingress Controller
🔄 Automated CI/CD pipeline to build, push, and deploy services
🔐 Sensitive credentials managed via Kubernetes Secrets

📦 Tech Stack
Frontend Services:
Vote app (Python / Flask)
Result app (Node.js / Express)
Backend Worker: .NET
Data Layer: Redis, PostgreSQL
Containerization: Docker
Orchestration: Kubernetes (Amazon EKS)
Ingress: NGINX Ingress Controller
CI/CD: GitHub Actions
Cloud Provider: AWS

⚙️ Deployment Overview
Microservices deployed as Kubernetes Deployments and Services
Internal communication via Kubernetes DNS (no hardcoded IPs)
Traffic routed via Ingress paths (/vote, /result)
CI/CD pipeline builds images, pushes to registry, and applies manifests automatically
