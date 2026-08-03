# Classroom Booking System – Cloud Native Multi-Cloud Architecture

A cloud-native Classroom Booking System developed using a microservices architecture. The project demonstrates modern DevOps practices by combining Infrastructure as Code, Kubernetes orchestration, CI/CD automation, and application monitoring across multiple cloud providers.

The application is deployed using a **multi-cloud architecture**, where the microservices run on **Hetzner Cloud** using Kubernetes (K3s), while the database is hosted on **AWS RDS**. The infrastructure is provisioned using Terraform, deployments are automated using Ansible, continuous integration is handled by Jenkins, and application monitoring is provided by Prometheus and Grafana.

---

# Features

- User Authentication Service
- Room Management Service
- Booking Management Service
- RESTful APIs
- Docker containerization
- Kubernetes (K3s) deployment
- Multi-cloud architecture (Hetzner + AWS)
- Infrastructure as Code using Terraform
- Configuration management using Ansible
- CI/CD using Jenkins
- Application monitoring with Prometheus
- Dashboard visualization with Grafana

---

# Multi-Cloud Architecture

```
                    GitHub
                       │
                       ▼
                 Jenkins Pipeline
                       │
                       ▼
                Docker Hub Images
                       │
                       ▼
                Ansible Deployment
                       │
                       ▼
          Hetzner Cloud (K3s Cluster)
      ┌──────────┬──────────┬──────────┐
      │          │          │          │
      ▼          ▼          ▼
 Auth Service  Room Service  Booking Service
      │          │          │
      └──────────┴──────────┘
               │
               ▼
        AWS RDS MySQL Database
               │
               ▼
          Prometheus Server
               │
               ▼
          Grafana Dashboard
```

---

# Technology Stack

| Category | Technology |
|----------|------------|
| Language | Java 17 |
| Framework | Spring Boot |
| Build Tool | Maven |
| Database | MySQL (AWS RDS) |
| Containerization | Docker |
| Container Registry | Docker Hub |
| Orchestration | Kubernetes (K3s) |
| Infrastructure | Terraform |
| Configuration Management | Ansible |
| CI/CD | Jenkins |
| Monitoring | Prometheus |
| Dashboard | Grafana |
| Cloud Providers | Hetzner Cloud & AWS |

---

# Project Structure

```
Student-team-beta
│
├── services
│   ├── auth-service
│   ├── room-service
│   └── booking-service
│
├── infrastructure
│   ├── terraform-hetzner
│   ├── kubernetes
│   └── ansible
│
├── Jenkinsfile
│
└── README.md
```

---

# Microservices

## Authentication Service

Responsible for:

- User authentication
- Login validation
- JWT token generation
- User management

---

## Room Service

Responsible for:

- Creating rooms
- Updating room information
- Retrieving available rooms
- Room management

---

## Booking Service

Responsible for:

- Creating bookings
- Updating bookings
- Viewing booking history
- Booking validation

---

# Infrastructure

Infrastructure is provisioned using **Terraform**.

Terraform automatically creates:

- Hetzner Virtual Machine
- Firewall Rules
- SSH Keys
- Public IPv4 Address

AWS provides:

- Amazon RDS MySQL Database

This setup separates the application layer from the database layer while reducing infrastructure costs.

---

# Kubernetes Deployment

The application is deployed on a single-node **K3s Kubernetes Cluster** running on Hetzner Cloud.

Kubernetes resources include:

- Deployments
- Services
- ConfigMaps
- Secrets
- Persistent Volume Claims
- Monitoring Namespace

Each microservice runs as an independent Kubernetes Deployment.

---

# Configuration Management

Ansible is used to automate deployments.

The deployment process:

- Copies Kubernetes manifests
- Applies ConfigMaps and Secrets
- Deploys microservices
- Deploys monitoring components
- Waits for successful rollout
- Verifies deployment health

Deployment command:

```bash
ansible-playbook -i inventory.ini deploy-kubernetes.yml
```

---

# CI/CD Pipeline

Jenkins automates the application build process.

Pipeline Flow

```
Developer
     │
 git push
     │
     ▼
GitHub Repository
     │
     ▼
Jenkins Pipeline
     │
     ▼
Build Spring Boot Applications
     │
     ▼
Create Docker Images
     │
     ▼
Push Images to Docker Hub
     │
     ▼
Run Ansible Deployment
     │
     ▼
Deploy to Kubernetes
     │
     ▼
Verify Application Health
```

The pipeline automatically:

- Builds all three microservices
- Creates Docker images
- Pushes images to Docker Hub
- Deploys the latest version to Kubernetes
- Verifies deployment status

---

# Monitoring

## Prometheus

Prometheus collects metrics from all three microservices using Spring Boot Actuator and Micrometer.

Metrics collected include:

- Application availability
- JVM memory usage
- CPU usage
- HTTP request metrics
- Response time
- JVM thread count

---

## Grafana

Grafana is connected to Prometheus to visualize application metrics.

Current dashboards include:

- Service Health
- JVM Memory Usage
- HTTP Request Metrics
- Response Time
- Application Availability

---

# Security

Sensitive configuration is stored using Kubernetes Secrets.

Examples include:

- Database credentials
- Grafana administrator credentials
- Application configuration

Configuration values are managed using Kubernetes ConfigMaps.

---

# Deployment Workflow

```
Developer
      │
      ▼
GitHub Repository
      │
      ▼
Jenkins Pipeline
      │
      ▼
Docker Hub
      │
      ▼
Ansible
      │
      ▼
Kubernetes Cluster
      │
      ▼
AWS RDS
```

---

# How to Run the Project

## Clone Repository

```bash
git clone https://github.com/<your-username>/Student-team-beta.git
```

---

## Provision Infrastructure

```bash
cd infrastructure/terraform-hetzner

terraform init

terraform plan

terraform apply
```

---

## Deploy Application

```bash
cd infrastructure/ansible

ansible-playbook -i inventory.ini deploy-kubernetes.yml
```

---

## Verify Deployment

```bash
k3s kubectl get deployments

k3s kubectl get pods

k3s kubectl get services
```

---

## Prometheus

Open:

```
http://<SERVER-IP>:32090
```

---

## Grafana

Open:

```
http://<SERVER-IP>:32300
```
---

# Future Improvements

- GitHub Webhooks for instant CI/CD
- SonarQube integration
- Automated testing in Jenkins

---

# Author

**Sanket Shetty**

Master's in Software Design with Cloud Native Computing

This project demonstrates the implementation of a complete cloud-native application using microservices, Kubernetes, Infrastructure as Code, CI/CD automation, monitoring, and a multi-cloud deployment architecture.