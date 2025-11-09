from flask import Flask, jsonify
import random

app = Flask(__name__)

# Middleware-like before request (simulate random failure)
@app.before_request
def random_failure():
    # 30% chance of failure
    if random.random() < 0.3:
        print("Simulated random failure!")
        return "Something went wrong!", 500

# Root route
@app.route("/")
def home():
    return "Hello! App is running fine."

# Data route
@app.route("/data")
def data():
    # Randomly simulate undefined error
    if random.random() < 0.3:
        x = None
        print(x.length)  # This will raise an AttributeError
    return jsonify({"message": "Data fetched successfully"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

