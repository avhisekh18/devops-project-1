from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "🚀 DevOps Project 1 — CI/CD Pipeline",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "development"),
        "version": os.getenv("APP_VERSION", "1.0.0")
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/info")
def info():
    return jsonify({
        "app": "containerized-cicd-demo",
        "author": "Your Name",
        "stack": ["Python", "Flask", "Docker", "GitHub Actions", "AWS"]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


def play():
    return jsonify({
        "football":"Score"
    })


def dance():
    return jsonify({
        "song":"point"
    })