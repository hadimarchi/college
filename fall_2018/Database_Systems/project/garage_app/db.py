from flask_sqlalchemy import SQLAlchemy
from configparser import ConfigParser


class mysqlDB:
    def __init__(self, app, config_filename):
        self.app = app
        self.config_db(config_filename)
        self.create_db()

    def config_db(self, config_filename):
        config = ConfigParser()
        config.read(config_filename)
        self.app.config['SQLALCHEMY_DATABASE_URI'] = (
                          f"mysql+pymysql://{config['credentials']['user']}"
                          f":{config['credentials']['pass']}@localhost/garage"
                          )

    def create_db(self):
        self.db = SQLAlchemy(self.app)
