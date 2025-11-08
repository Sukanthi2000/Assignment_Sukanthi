# Flask App Kubernetes Deployment - Minikube

This repository demonstrates how to **Dockerize a Python Flask app** and deploy it to a **local Kubernetes cluster using Minikube**. It includes an optional **Ingress** configuration for domain-based access and step-by-step commands you can copy into a `README.md` file.

---

## Prerequisites

Make sure the following tools are installed and running:

- **Minikube**
- **kubectl**
- **Docker**

Run these commands to verify and start Minikube:

```bash
minikube start --driver=docker
kubectl version --client
docker version
```

**Tip:** If Minikube runs with the Docker driver, both share the same Docker environment. Images built locally can be used directly by Minikube.

---

## Project Structure

```
k8s-deploy-demo/
├── app.py
├── requirements.txt
├── Dockerfile
├── deployment.yaml
├── service.yaml
└── ingress.yaml  # optional for bonus
```

---

## Dockerize Your App

Build and tag the Docker image so Minikube can use it:

```bash
# Point your shell to Minikube's Docker daemon
eval $(minikube docker-env)

# Build the image and tag it
docker build -t flask-k8s-demo:latest .
```

---

## Deploy to Minikube

Apply the Kubernetes manifests to create the Deployment and Service:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

---

## Verify Deployment

Check the status of your deployment, pods, and service:

```bash
kubectl get deployments
kubectl get pods
kubectl get svc
```

You should see two pods running and the service exposed via a **NodePort**.

---

## Access the App

Get Minikube’s IP address:

```bash
minikube ip
```

If the IP is `192.168.49.2` and the NodePort is `30080`, open:

```
http://192.168.49.2:30080
```

Expected response:

```
Hello from Jenkins + Docker + Python CI/CD Pipeline!
```

---

## Bonus Ingress

Enable the Ingress addon in Minikube and apply your ingress manifest:

```bash
minikube addons enable ingress
kubectl apply -f ingress.yaml
```

Update your `/etc/hosts` file with the Minikube IP and hostname:

```
<minikube-ip> flask.local
```

Then visit:

```
http://flask.local
```

---

## Troubleshooting

### Pod not starting or CrashLoopBackOff

```bash
kubectl logs <pod-name>
```

**Check:** Ensure the Flask app binds to `0.0.0.0:5000` inside the container.

### Cannot access NodePort

```bash
minikube ip
kubectl get svc
```

**Check:** Confirm the NodePort shown by `kubectl get svc` matches the port you are using in the browser. If running on cloud VMs, ensure the security group allows the NodePort.

### Ingress not working

```bash
minikube addons enable ingress
kubectl get pods -n ingress-nginx
```

**Check:** Ensure the Ingress addon is enabled and your `/etc/hosts` entry points the hostname to the Minikube IP.

### Using a local Docker image with Minikube

```bash
eval $(minikube docker-env)
docker build -t flask-k8s-demo:latest .
```

**Note:** Building the image after running `eval $(minikube docker-env)` ensures Minikube can use the locally built image.

### Port-forward alternative

If NodePort is inaccessible, use port-forwarding:

```bash
kubectl port-forward --address 0.0.0.0 service/flask-service 5000:5000
```

Then open:

```
http://<your-host-ip>:5000
```

---

## Quick Start

Run these commands for a fast setup:

```bash
# 1. Start Minikube with Docker driver
minikube start --driver=docker

# 2. Build Docker image for Minikube
eval $(minikube docker-env)
docker build -t flask-k8s-demo:latest .

# 3. Deploy to Minikube
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# 4. Get Minikube IP
minikube ip

# 5. Open in browser
# http://<minikube-ip>:30080
```

---

## Summary

- **Flask app** running in Docker  
- **Deployed to Kubernetes** using Minikube  
- **Service** exposed via NodePort  
- **Optional Ingress** for domain-based access

Use the commands and manifests in this README to reproduce the setup locally and iterate on your Kubernetes deployment.
