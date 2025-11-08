# 🚀 Infrastructure Automation with Shell + Docker Compose

This project simulates a DevOps automation pipeline locally—without relying on any cloud services. It uses Docker Compose to orchestrate multiple services and a shell script to automate environment setup.

---

## 📦 Services Included

| Service     | Purpose                        | Port |
|-------------|--------------------------------|------|
| Jenkins     | CI/CD automation server        | 8080 |
| Redis       | In-memory data store           | 6379 |
| Nginx       | Reverse proxy for sample app   | 80   |
| Sample App  | Simple Flask web application   | 5000 |

---

## 🧰 Prerequisites

- Docker
- Docker Compose
- Bash shell (Linux/macOS or WSL on Windows)

---

### 🛠️ Setup Instructions

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/infra-automation.git
cd infra-automation
2. Run the setup script
bash
Copy code
./setup.sh
This script will:

✅ Check for Docker and Docker Compose

🔨 Build and start all services

📋 Display container health status

📂 Show recent logs for debugging
