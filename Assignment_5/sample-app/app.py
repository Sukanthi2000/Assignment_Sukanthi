from flask import Flask, jsonify
import os
import redis

app = Flask(__name__)

REDIS_HOST = os.environ.get("REDIS_HOST", "redis")
r = redis.Redis(host=REDIS_HOST, port=6379, db=0, socket_connect_timeout=2)

@app.route('/')
def index():
    try:
        r.incr("visits")
        visits = r.get("visits") or b"0"
        return f"Hello — visits: {int(visits)}\n", 200
    except Exception:
        return "Hello — Redis unavailable\n", 200

@app.route('/health')
def health():
    # Simple health endpoint
    try:
        if r.ping():
            return jsonify(status="ok"), 200
    except Exception:
        pass
    return jsonify(status="unhealthy"), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
