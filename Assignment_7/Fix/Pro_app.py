from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello! App is running fine."

@app.route("/data")
def data():
    x = "Some data"  # Safe value
    try:
        length = len(x)
        print(f"Length of x: {length}")
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": "Internal error"}), 500

    return jsonify({"message": "Data fetched successfully"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
