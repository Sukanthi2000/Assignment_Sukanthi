Perfect — this is the **GitOps simulation section** of your DevOps assignment 🚀
Let’s walk through how to **set up Argo CD on Minikube (or kind)** and connect it with a GitHub repo so that deployments automatically sync from Git pushes.

We’ll go step-by-step so you can reproduce it locally and even showcase it in a demo/report.

---

## 🎯 Objective

Use **Argo CD** to implement GitOps-style continuous deployment — where **Git is the single source of truth**, and Kubernetes automatically syncs from Git changes.

---

## 🧩 Step 1 — Prerequisites

Make sure you have these installed locally:

```bash
kubectl version --client
minikube version   # or kind version
git --version
```

If using **Minikube**, start it:

```bash
minikube start
```

Check the context:

```bash
kubectl config current-context
```

---

## 🧩 Step 2 — Install Argo CD

Create a namespace:

```bash
kubectl create namespace argocd
```

Install Argo CD:

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify pods:

```bash
kubectl get pods -n argocd
```

---

## 🧩 Step 3 — Expose Argo CD UI

You can use **port-forward** for simplicity:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Now open:
👉 [https://localhost:8080](https://localhost:8080)

---

## 🧩 Step 4 — Login to Argo CD

Get the admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
```

Login via CLI:

```bash
argocd login localhost:8080 --username admin --password <the_password> --insecure
```

---

## 🧩 Step 5 — Create a simple app in Git

Create a new GitHub repo, e.g.
👉 `https://github.com/Sukanthi2000/argo-sample-app`

Inside that repo, create a folder:

```
k8s/
├── deployment.yaml
└── service.yaml
```

Example files 👇

**deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-sample-app
  labels:
    app: my-sample-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-sample-app
  template:
    metadata:
      labels:
        app: my-sample-app
    spec:
      containers:
        - name: my-sample-app
          image: nginx:1.23
          ports:
            - containerPort: 80
```

**service.yaml**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-sample-service
spec:
  selector:
    app: my-sample-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
```

Push this to GitHub.

---

## 🧩 Step 6 — Connect Argo CD to Git Repo

In CLI:

```bash
argocd repo add https://github.com/Sukanthi2000/argo-sample-app.git
```

Create an Argo CD app:

```bash
argocd app create sample-app \
  --repo https://github.com/Sukanthi2000/argo-sample-app.git \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default
```

---

## 🧩 Step 7 — Sync the App

```bash
argocd app sync sample-app
```

Check status:

```bash
argocd app get sample-app
```

✅ You’ll see the app deployed in Kubernetes.

---

## 🧩 Step 8 — Demonstrate GitOps Automation

Now edit your `deployment.yaml` in GitHub:

```yaml
image: nginx:1.24
```

Commit and push:

```bash
git commit -am "Updated image version to 1.24"
git push
```

Within 30–60 seconds, Argo CD will detect the change and auto-sync the new version (you can see this on the UI or via CLI):

```bash
argocd app get sample-app
```

---

## 🧾 Step 9 — Document / Submit

Create a small report (Markdown or PDF):

### 📘 *GitOps with Argo CD – Summary*

| Step | Description                                       |
| ---- | ------------------------------------------------- |
| 1    | Installed Argo CD on Minikube                     |
| 2    | Created GitHub repo with K8s manifests            |
| 3    | Connected repo to Argo CD                         |
| 4    | Verified sync and deployment                      |
| 5    | Updated image → Argo CD auto-deployed new version |

Add screenshots of:

* Argo CD UI (Application → Synced)
* Pod list in Kubernetes showing image tag
* GitHub commit

---

Would you like me to create a **ready-to-upload GitHub repo folder structure (with sample manifests and README.md)** for your *Assignment_6* Argo CD section?
You could then just push it to your GitHub to demonstrate it instantly.
