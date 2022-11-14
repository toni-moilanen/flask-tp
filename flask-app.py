from flask import Flask
from getter import haeRavintoloidenMenut

app = Flask(__name__)

@app.route("/")
def hello():
    return "<p>hello</p>"

@app.route("/api/restaurants")
def get():
    return haeRavintoloidenMenut()