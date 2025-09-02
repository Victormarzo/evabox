from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from .database import get_db
from typing import List, Optional
from . import models
from . import schemas 
app = FastAPI(title="EVA BOX")

@app.get("/")
def root():
    return{"message":"EVA BOX"}

#Subject Routes 
@app.get("/subjects", response_model=List[schemas.SubjectDetailResponse])
def read_subjects(skip: int = 0, limit: int =100,db: Session = Depends(get_db)):
    subjects = db.query(models.Subject).offset(skip).limit(limit).all()
    return subjects

@app.post("/subjects", response_model= schemas.SubjectResponse)
def create_subject(subject:schemas.SubjectCreate, db:Session = Depends(get_db)):
    print(0,subject)
    db_subject = models.Subject(**subject.model_dump())
    print(1,db_subject)
    db.add(db_subject)
    db.commit()
    db.refresh(db_subject)
    return db_subject

#Topic Routes
@app.get("/topics", response_model=List[schemas.TopicDetailResponse])
def read_topics(skip: int = 0, limit: int =100,db: Session = Depends(get_db)):
    topics = db.query(models.Topic).offset(skip).limit(limit).all()
    return topics

@app.post("/topics", response_model= schemas.TopicDetailResponse)
def create_topic(topic:schemas.TopicCreate, db:Session = Depends(get_db)):
    subject = db.query(models.Subject).filter(models.Subject.id == topic.subject_id).first()
    if not subject:
        raise HTTPException(status_code=404, detail="Subject not found")
    db_topic = models.Topic(**topic.model_dump())
    db.add(db_topic)
    db.commit()
    db.refresh(db_topic)
    return db_topic

# Question routes
@app.post("/questions/", response_model=schemas.QuestionResponse)
def create_question(question: schemas.QuestionCreate, db: Session = Depends(get_db)):
    subject = db.query(models.Subject).filter(models.Subject.id == question.subject_id).first()
    if not subject:
        raise HTTPException(status_code=404, detail="Subject not found")
    
    topic = db.query(models.Topic).filter(models.Topic.id == question.topic_id).first()
    if not topic:
        raise HTTPException(status_code=404, detail="Topic not found")
    
    if topic.subject_id != question.subject_id:
        raise HTTPException(
            status_code=400, 
            detail="Topic does not belong to the specified subject"
        )
    
    db_question = models.Question(
        name=question.name,
        subject_id=question.subject_id,
        topic_id=question.topic_id
    )
    db.add(db_question)
    db.commit()
    db.refresh(db_question)
    
    for option_data in question.answer_options:
        db_option = models.AnswerOption(
            text=option_data.text,
            is_correct=option_data.is_correct,
            question_id=db_question.id
        )
        db.add(db_option)
    
    db.commit()
    db.refresh(db_question)
    return db_question


@app.get("/questions/", response_model=List[schemas.QuestionResponse])
def read_questions(
    subject_id: Optional[int] = None,
    topic_id: Optional[int] = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    query = db.query(models.Question)
    print(subject_id)
    print(topic_id)
    if subject_id:
        query = query.filter(models.Question.subject_id == subject_id)
    
    if topic_id:
        query = query.filter(models.Question.topic_id == topic_id)
    print(query)
    questions = query.offset(skip).limit(limit).all()
    return questions