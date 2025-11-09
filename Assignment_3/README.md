
# 🚀 GitOps with Argo CD — Deployment Simulation (Using kind / EC2)

## 🎯 Objective

To simulate a **GitOps-style Continuous Deployment** workflow using **Argo CD**, where any change pushed to a Git repository automatically updates the Kubernetes cluster — making Git the *single source of truth*.

---

## 🧩 Step-by-Step Summary

### **1️⃣ Setup & Environment**

* Installed and configured **Kubernetes** locally using **kind** (running inside EC2).
* Installed **Argo CD** in a separate namespace (`argocd`).
* Verified pods and services were running successfully using:

  ```
  kubectl get pods -n argocd
  kubectl get svc -n argocd
  ```

---

### **2️⃣ Exposing Argo CD Dashboard**

* Exposed Argo CD UI using **port-forwarding**:

  ```
  kubectl port-forward svc/argocd-server -n argocd --address 0.0.0.0 9090:443
  ```
* Accessed the UI at:
  👉 **https://<EC2-public-IP>:9090**

---

### **3️⃣ Logging into Argo CD**

* Retrieved the initial admin password using:

  ```
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  ```
* Logged in successfully to the Argo CD dashboard with username **admin**.

---

### **4️⃣ Git Repository Connection**

* Linked Argo CD with a GitHub repository containing Kubernetes manifests (Deployment & Service).
* Verified repository sync and cluster connection.

---

### **5️⃣ Application Creation & Sync**

* Created an application in the Argo CD UI (using the Git repo and manifest path).
* Synced the app to deploy automatically to the cluster.
* Verified successful deployment under:

  ```
  kubectl get all
  ```

---

### **6️⃣ GitOps in Action**

* Updated the application image version in GitHub (e.g., from `nginx:1.23` → `nginx:1.24`).
* After pushing the commit, Argo CD automatically detected the change and redeployed the updated version.
* Verified auto-sync and rollout from both UI and terminal.

---

## 🧰 Common Troubleshooting Steps

| Issue                           | Root Cause                                  | Fix                                                       |
| ------------------------------- | ------------------------------------------- | --------------------------------------------------------- |
| ❌ *UI not accessible on EC2*    | Port-forward was bound to `localhost` only  | Use `--address 0.0.0.0` to make it accessible externally  |
| ⚠️ *App path does not exist*    | Wrong repo folder or path provided          | Verify correct manifest folder path in Argo CD app config |
| 🔒 *Login failure in UI*        | Password not decoded correctly              | Always decode with `base64 -d`                            |
| 🌐 *Service not reachable*      | Kind is not exposed publicly                | Use `NodePort` or port-forward the service manually       |
| 🐳 *Sync errors (invalid spec)* | App name or metadata not RFC 1123 compliant | Use lowercase names and avoid spaces or special chars     |
| 🔁 *Auto-sync not happening*    | Auto-sync disabled in Argo CD               | Enable Auto Sync from UI (App → Settings → Sync Policy)   |


---

## ✅ Outcome

Successfully implemented **GitOps workflow using Argo CD**:

* Fully automated sync between **GitHub** and **Kubernetes**.
* Hands-free deployment triggered by **Git commit**.
* Clear visibility and version control via **Argo CD Dashboard**.

---

