from garage_app import garage_db


class Customer(garage_db.db.Model):
    __tablename__ = "Customer"
    ID = garage_db.db.Column(
        garage_db.db.Integer, primary_key=True, autoincrement=True
    )
    firstName = garage_db.db.Column(
               garage_db.db.String(45), nullable=False
    )
    lastName = garage_db.db.Column(
              garage_db.db.String(45), nullable=False
    )
    phoneNumber = garage_db.db.Column(
                 garage_db.db.String(10), nullable=False
    )

    vehicles = garage_db.db.relationship('Vehicle', backref="Owner", lazy=True)
    payments = garage_db.db.relationship('Job', backref="Customer", lazy=True)
