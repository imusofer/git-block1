from flask import Flask
import os
from datetime import datetime
from zoneinfo import ZoneInfo
import time

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
def time_route():
    return f"Current time in UTC: {datetime.now(ZoneInfo('UTC')).isoformat()}\nCurrent time in Sofia: {datetime.now(ZoneInfo('Europe/Sofia')).isoformat()}\n"

if __name__ == "__main__":
    startupDelay = int(os.getenv('STARTUP_DELAY', '0'))

    if startupDelay > 0:
        print(f"It's sleepy time for {startupDelay} seconds...", flush=True)
        time.sleep(startupDelay)
        
    app.run(host="0.0.0.0", port=5000)

