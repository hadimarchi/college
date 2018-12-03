from app import garage_db


class Worker(garage_db.db.Model):
    __tablename__ = "Worker"

    ID = garage_db.db.Column(
        garage_db.db.Integer, primary_key=True, autoincrement=True
    )
    username = garage_db.db.Column(
              garage_db.db.String(45), primary_key=True
    )
    passwordHash = garage_db.db.Column(
                  garage_db.db.String(64), nullable=False
    )
    firstName = garage_db.db.Column(
               garage_db.db.String(45), nullable=False
    )
    lastName = garage_db.db.Column(
              garage_db.db.String(45), nullable=False
    )
    admin = garage_db.db.Column(
           garage_db.db.Boolean, default=False
    )
    hireDate = garage_db.db.Column(
              garage_db.db.Date, nullable=False
    )
    hourlyRate = garage_db.db.Column(
                garage_db.db.Double, nullable=False
    )

    jobs = garage_db.db.relationship('Worked_On', backref='Worker', lazy=True)


class Worked_On(garage_db.db.Model):
    __tablename__ = "Worked_On"

    jobID = garage_db.db.Column(
           garage_db.db.Integer, garage_db.db.ForeignKey('Job.ID'),
           primary_key=True
    )
    workerID = garage_db.db.Column(
              garage_db.db.Integer, garage_db.db.ForeignKey('Worker.ID'),
              primary_key=True
    )
