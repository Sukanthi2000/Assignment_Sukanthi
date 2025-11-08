from flask import Flask, Response
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# Define a Prometheus counter metric
REQUEST_COUNT = Counter('app_requests_total', 'Total number of requests')

@app.route('/')
def index():
    REQUEST_COUNT.inc()
    return "Hello, world!"

@app.route('/metrics')
def metrics():
    # Return metrics with the correct Prometheus content type
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    # Bind to all interfaces so Prometheus can reach it
    app.run(host='0.0.0.0', port=5000)
