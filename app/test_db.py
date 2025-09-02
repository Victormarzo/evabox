from app.database import SessionLocal
from models import Subject

with SessionLocal() as db:
    subjects = db.query(Subject).all()
    print(subjects)