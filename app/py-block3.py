from flask import Flask
import os
from datetime import datetime
from zoneinfo import ZoneInfo

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello, World!\n"

@app.route("/health")
def health():
    return "Healthy\n"

@app.route("/config")
def config():
    return f"Config:\nApp env: {os.getenv('APP_ENV', 'default')}\nApp ver: {os.getenv('APP_VERSION', 'default')}\n"

@app.route("/time")
def time():
    return f"Current time in UTC: {datetime.now(ZoneInfo('UTC')).isoformat()}\nCurrent time in Sofia: {datetime.now(ZoneInfo('Europe/Sofia')).isoformat()}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
