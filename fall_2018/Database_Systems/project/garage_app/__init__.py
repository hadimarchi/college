from flask import Flask, render_template, current_app, g
from .db import get_db


def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
    with app.app_context():
        db = get_db()

    @app.route('/')
    def index():
        return render_template('index.html')

    @app.route('/testdb')
    def test_db():
        try:
            db.session.query("1").from_statement("SELECT 1").all()
            return 'Working'
        except Exception as e:
            return str(e)

    return app
