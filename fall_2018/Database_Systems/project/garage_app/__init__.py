from flask import Flask, render_template, current_app, g
from db import garageDB


app = Flask(__name__)
garage_db = garageDB(app)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/testdb')
def test_db():
    try:
        garage_db.db.session.query("1").from_statement("SELECT 1").all()
        return 'Working'
    except Exception as e:
        return str(e)


if __name__ == "__main__":
    app.run()
