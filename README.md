# 🚀 DevOps Project 1 — Containerized App with CI/CD Pipeline

![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python_3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)

> A production-grade CI/CD pipeline that automatically tests, builds, and deploys
> a containerized Python web application using Jenkins and Docker.

---

## 📸 Pipeline in Action
```
Developer pushes code
        │
        ▼
┌───────────────────────────────────────┐
│           Jenkins Pipeline             │
│                                       │
│  Stage 1      Stage 2      Stage 3    │
│  Checkout  →  Test      →  Build   →  │
│  from Git     pytest       Docker     │
│                                       │
│  Stage 4                              │
│  Deploy                               │
│  Container                            │
└───────────────────────────────────────┘
        │
        ▼
App live at http://localhost:5000 ✅
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Python 3.12 + Flask | Web application |
| Gunicorn | Production WSGI server |
| Docker | Containerization |
| Nginx | Reverse proxy |
| Jenkins | CI/CD automation |
| pytest | Automated testing |
| ngrok | Webhook tunneling |
| GitHub | Source control |

---

## ✨ Key Features

- **Automated testing** — pytest runs on every push, blocking bad code from deploying
- **Multi-stage Docker build** — separates build from production, keeping images lean
- **Jenkins Pipeline as Code** — entire pipeline defined in `Jenkinsfile`
- **Health check & auto rollback** — if deployment fails health check, container stops automatically
- **Non-root container** — app runs as unprivileged user for security
- **Webhook triggered** — pipeline fires automatically on every git push
- **Branch protection** — main branch protected, all changes via pull requests

---

## 📁 Project Structure
```
devops-project-1/
├── .github/
├── app/
│   ├── app.py              # Flask application
│   ├── requirements.txt    # Python dependencies
│   └── test_app.py         # Pytest test suite (4 tests)
├── nginx/
│   └── nginx.conf          # Reverse proxy config
├── Dockerfile              # Multi-stage build
├── docker-compose.yml      # Local development
├── Jenkinsfile             # CI/CD pipeline definition
├── .dockerignore
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites
- Docker Desktop
- Jenkins
- Python 3.12
- ngrok (for webhook)

### Run Locally
```bash
git clone https://github.com/avhisekh18/devops-project-1.git
cd devops-project-1
docker compose up --build
```

Visit:
- `http://localhost` — via Nginx
- `http://localhost:5000` — direct Flask

### Run Tests
```bash
cd app
pip install -r requirements.txt
pytest test_app.py -v
```

---

## 🔀 Branch Strategy
```
main      → production only, protected ✅
dev       → integration branch
feature/* → individual features
```

All changes go through Pull Requests — no direct pushes to main.

---

## 🔒 Security Highlights

- Container runs as **non-root user**
- Nginx security headers on all responses
- Branch protection rules enforced
- No secrets committed to repository

---

## 📈 What I Learned

- Building multi-stage Jenkins pipelines with Groovy
- Multi-stage Docker builds to minimize image size
- Setting up webhook triggers with ngrok
- Implementing health checks and automatic rollback
- Git branching strategies used in professional teams
- Writing pytest test suites as deployment gates

---

## 🗺️ Project Roadmap

- [x] Containerized Flask app
- [x] Jenkins CI/CD pipeline
- [x] Automated testing gate
- [x] Docker multi-stage build
- [x] Webhook auto-trigger
- [ ] AWS ECR + EC2 deployment *(coming soon)*
- [ ] Terraform infrastructure as code
- [ ] Kubernetes deployment

---

*Part of my DevOps Portfolio — building 5 progressively advanced projects.*  
*Connect with me on [LinkedIn](https://www.linkedin.com/in/avhisekh-dhungana-1b6727258)*