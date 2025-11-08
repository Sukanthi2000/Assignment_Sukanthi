Here's a complete guide to help you deploy a local monitoring stack using Prometheus and Grafana for a containerized app:

---

## 🚀 Step-by-Step Guide: Monitoring Stack with Prometheus + Grafana

### 🧩 1. Set Up a Sample App with `/metrics` Endpoint

You can use a simple Python Flask app with `prometheus_client`:

```python
# app.py
from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)
REQUEST_COUNT = Counter('app_requests_total', 'Total number of requests')

@app.route('/')
def home():
    REQUEST_COUNT.inc()
    return "Hello, World!"

@app.route('/metrics')
def metrics():
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

**Dockerfile:**

```Dockerfile
FROM python:3.9
WORKDIR /app
COPY app.py .
RUN pip install flask prometheus_client
EXPOSE 5000
CMD ["python", "app.py"]
```

---

### 🐳 2. Deploy Prometheus + Grafana Using Docker Compose

**Directory Structure:**

```
monitoring/
├── docker-compose.yml
├── prometheus/
│   └── prometheus.yml
```

**`prometheus/prometheus.yml`:**

```yaml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: 'sample-app'
    static_configs:
      - targets: ['sample-app:5000']
```

**`docker-compose.yml`:**

```yaml
version: '3.8'
services:
  sample-app:
    build: .
    ports:
      - "5000:5000"

  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    volumes:
      - grafana-storage:/var/lib/grafana

volumes:
  grafana-storage:
```

Run with:

```bash
docker-compose up --build
```

---

### 📊 3. Visualize Custom Metrics in Grafana

1. Access Grafana at `http://localhost:3000`
2. Login (default: `admin` / `admin`)
3. Add Prometheus as a data source:
   - URL: `http://prometheus:9090`
4. Create a new dashboard:
   - Add a panel with query: `app_requests_total`

---

### 📤 4. Create and Export a Dashboard

1. After creating your dashboard:
   - Click the **gear icon** → **JSON Model**
   - Click **Export** to download the dashboard JSON
2. You can reuse this JSON to import the dashboard later or share it with others.

---

Would you like me to generate a sample dashboard JSON or help you customize the metrics further?