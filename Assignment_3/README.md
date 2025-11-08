# 🚀 Flask CI/CD with GitHub Actions + Docker + Kubernetes (Kind)

This project demonstrates a complete CI/CD pipeline using **GitHub Actions**, **Docker**, and **Kubernetes (Kind)** to build, test, and deploy a Flask application.

---

## 📌 Project Structure

- Assignment_3/
  - app.py
  - requirements.txt
  - Dockerfile
  - deployment.yaml
  - service.yaml
  - ingress.yaml (optional)




## 🎯 Objective

Set up a local CI/CD pipeline that:
- Builds and tests a Flask app
- Builds and optionally pushes a Docker image to Docker Hub
- Deploys the app to a local Kubernetes cluster using **Kind**
- Verifies deployment by testing the service endpoint

---

## ⚙️ GitHub Actions Workflow

The workflow is triggered on every push to the `main` branch.

### Key Steps:
1. **Checkout Code** – Pulls the latest code from the repository.
2. **Set Up Python** – Installs Python 3.11 and dependencies.
3. **Run Tests** – Placeholder for future test scripts.
4. **Build Docker Image** – Builds the image `flask-k8s-demo:latest`.
5. **Push to Docker Hub** *(optional)* – Uses GitHub Secrets for authentication.
6. **Install and Set Up Kind** – Creates a local Kubernetes cluster.
7. **Load Image into Kind** – Makes the Docker image available to the cluster.
8. **Deploy to Kubernetes** – Applies the deployment and service manifests.
9. **Debug and Wait** – Waits for pods to be ready and prints logs.
10. **Test the App** – Sends a request to the Flask app via NodePort.

---

## 🔐 Secrets Required

To push the Docker image to Docker Hub, add the following secrets to your GitHub repository:

- `DOCKER_USERNAME` – Your Docker Hub username
- `DOCKER_PASSWORD` – Your Docker Hub password or access token

---

## 🧪 Testing the App

The Flask app is exposed via a Kubernetes **NodePort** service on port `30080`. The workflow uses:
> To verify the app is running:
>
> **Note:** This test runs inside the GitHub Actions runner. The app is not accessible from outside the workflow.

---

## 🛠️ Deployment Manifests

### `deployment.yaml`
Defines a **Deployment** with 2 replicas of the Flask container.

### `Service.yaml`
Defines a **NodePort** service exposing the app on port `30080`.

---

## 🧰 Requirements

- **Docker** — to build and run container images  
- **GitHub Actions** — workflow runs on `ubuntu-latest` virtual environment  
- **Kubernetes CLI (`kubectl`)** — to interact with the Kubernetes cluster  
- **Kind CLI** — to create and manage the local Kubernetes cluster within the workflow


