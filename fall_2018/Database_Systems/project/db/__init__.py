from flask_sqlalchemy import SQLAlchemy
from configparser import ConfigParser
from app import app


def config_db():
    config = ConfigParser()
    config.read('db.ini')
    app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql://{config['credentials']['user']}"
    f":{config['credentials']['pass']}j@localhost/garage"


config_db()
db = SQLAlchemy(app)
