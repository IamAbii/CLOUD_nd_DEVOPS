from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hii ABHIII, This Development is successful"

if __name__ == "__main__":80
    app.run(host="0.0.0.0", port=)