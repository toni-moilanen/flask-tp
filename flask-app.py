from flask import Flask
from flask_cors import CORS
from getter import haeRavintoloidenMenut

app = Flask(__name__)
CORS(app)

@app.route("/")
def hello():
    return "<p>hello</p>"

@app.route("/api/restaurants")
def get():
    return haeRavintoloidenMenut()