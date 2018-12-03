from app import garage_db


class Vehicle(garage_db.db.Model):
    __tablename__ = "Vehicle"

    ID = garage_db.db.Column(
        garage_db.db.Integer, primary_key=True, autoincrement=True
    )
    customerID = garage_db.db.Column(
                garage_db.db.Integer, garage_db.db.ForeignKey('Owner.ID'),
                nullable=False
    )
    make = garage_db.db.Column(
          garage_db.db.String(45), nullable=False
    )
    model = garage_db.db.Column(
           garage_db.db.String(45), nullable=False
    )
    year = garage_db.db.Column(
          garage_db.db.Year, nullable=False
    )

    jobs = garage_db.db.relationship('Vehicle', backref='Vehicle', lazy=True)


class Job(garage_db.db.Model):
    __tablename__ = "Job"

    ID = garage_db.db.Column(
        garage_db.db.Integer, primary_key=True, autoincrement=True
    )
    vehicleID = garage_db.db.Column(
                garage_db.db.Integer, garage_db.db.ForeignKey('Vehicle.ID')
    )
    payingCustomerID = garage_db.db.Column(
                      garage_db.db.Integer, garage_db.db.ForeignKey('Customer.ID')
    )
    cost = garage_db.db.Column(
          garage_db.db.Integer, nullable=False
    )

    workers = garage_db.db.relationship('Worked_On', backref='Job', lazy=True)
