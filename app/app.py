from flask import Flask
import socket
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def home():
    return f"""
    <h1>Hello DevOps 🚀</h1>
    <p>Application is running successfully!</p>
    <p><b>Hostname:</b> {socket.gethostname()}</p>
    <p><b>Time:</b> {datetime.now()}</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
