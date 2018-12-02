from flask_sqlalchemy import SQLAlchemy
from configparser import ConfigParser


class garageDB:
    def __init__(self, app):
        self.app = app
        self.config_db()
        self.create_db()

    def config_db(self):
        config = ConfigParser()
        config.read('db.ini')
        self.app.config['SQLALCHEMY_DATABASE_URI'] = (
                          f"mysql+pymysql://{config['credentials']['user']}"
                          f":{config['credentials']['pass']}@localhost/garage"
                          )

    def create_db(self):
        self.db = SQLAlchemy(self.app)
