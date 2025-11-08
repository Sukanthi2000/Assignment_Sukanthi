
# 📦 Monitoring Stack with Prometheus + Grafana

This project sets up a containerized Python Flask application with a `/metrics` endpoint, monitored using Prometheus and visualized through Grafana.

---

## 📁 Folder Structure

```
Assignment_6/
├── app.py                  # Flask app exposing Prometheus metrics
├── Dockerfile              # Container setup for the Flask app
├── docker-compose.yaml     # Orchestration of all services
├── prometheus/
│   └── prometheus.yml      # Prometheus configuration
└── README.md               # Project documentation
```

---

## 🚀 Setup Instructions

### 1. Build and Launch the Stack

From the `Assignment_6/` directory, run:

```bash
docker-compose up --build
```

This will start the following services:
- **sample-app**: Flask app exposing metrics at `/metrics`
- **prometheus**: Scrapes metrics from the app
- **grafana**: Visualizes metrics from Prometheus

---

## 🔗 Prometheus Configuration

Prometheus is configured via `prometheus/prometheus.yml` to scrape metrics from the Flask app:

```yaml
scrape_configs:
  - job_name: 'sample-app'
    static_configs:
      - targets: ['sample-app:5000']
```

- Prometheus scrapes the `/metrics` endpoint every 5 seconds.
- Access Prometheus UI at: [http://localhost:9090](http://localhost:9090)

---

## 📊 Grafana Setup & Prometheus Connection

1. **Access Grafana**  
   Open [http://localhost:3000](http://localhost:3000)  
   Default login:  
   - **Username**: `admin`  
   - **Password**: `admin`

2. **Add Prometheus as a Data Source**  
   - Go to **Settings → Data Sources → Add data source**
   - Choose **Prometheus**
   - Set the URL to: `http://prometheus:9090`
   - Click **Save & Test**

3. **Create a Dashboard**  
   - Click **+ → Dashboard → Add new panel**
   - In the query field, enter: `app_requests_total`
   - Choose visualization type (e.g., Graph, Gauge)
   - Click **Apply** to save the panel

---

## 📤 Exporting Dashboards

To export your dashboard:
- Open the dashboard
- Click the **gear icon (⚙️)** → **JSON Model**
- Click **Export** to download the dashboard JSON
- You can import this JSON later to reuse or share the dashboard

---

## 🛠️ Troubleshooting

- **Prometheus target not showing as "UP"**:
  - Visit [http://localhost:9090/targets](http://localhost:9090/targets)
  - Ensure the `sample-app` target is listed and its status is **UP**
  - If it's **DOWN**, check:
    - The Flask app is running and accessible at `sample-app:5000`
    - The `prometheus.yml` target matches the service name and port
    - No port conflicts or container startup errors

- **Grafana can't connect to Prometheus**:
  - Verify Prometheus is running at `http://prometheus:9090`
  - Ensure the Docker network allows inter-service communication
  - Restart Grafana and reconfigure the data source if needed

- **No data in Grafana panel**:
  - Confirm Prometheus is scraping metrics (`/metrics` endpoint returns data)
  - Check the query in the panel (e.g., `app_requests_total`)
  - Adjust the time range in the dashboard to include recent data

---

