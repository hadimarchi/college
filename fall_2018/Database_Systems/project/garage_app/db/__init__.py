#!~/virtual_environments/db_proj/bin/python
from flask import current_app, g
from flask_sqlalchemy import SQLAlchemy
from configparser import ConfigParser


def config_db():
    config = ConfigParser()
    config.read('garage_app/db.ini')
    current_app.config['SQLALCHEMY_DATABASE_URI'] = (
                      f"mysql+pymysql://{config['credentials']['user']}"
                      f":{config['credentials']['pass']}@localhost/garage"
                      )


def get_db():
        if 'db' not in g:
            config_db()
            g.db = SQLAlchemy(current_app)
        return g.db
