from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from .database import get_db,Base,engine
from typing import List, Optional
from . import models
from . import schemas 
import random

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

#Test Routes

@app.post("/tests/generate", response_model=schemas.TestResponse)
def generate_test(
    test_config: schemas.TestConfig,
    db: Session = Depends(get_db)
):
    # Build query based on config
    query = db.query(models.Question)

    if test_config.subject_id:
        query = query.filter(models.Question.subject_id == test_config.subject_id)
    
    if test_config.topic_id:
        query = query.filter(models.Question.topic_id == test_config.topic_id)
    
    # Get all matching questions
    questions = query.all()
    
    # Check if we have enough questions
    if len(questions) < test_config.num_questions:
        raise HTTPException(
            status_code=400,
            detail=f"Only {len(questions)} questions available. Requested {test_config.num_questions}."
        )
    
    # Select random questions
    selected_questions = random.sample(questions, test_config.num_questions)
   


    # Create test record
    db_test = models.Test(
        num_questions=test_config.num_questions,
        subject_id=test_config.subject_id,
        topic_id=test_config.topic_id
    )
    
    db.add(db_test)
    db.commit()
    db.refresh(db_test)
    
    # Add questions to test
    for question in selected_questions:
        
        test_question = models.TestQuestion(
            test_id=db_test.id,
            
            question_id=question.id,
        )
        db.add(test_question)
    
    db.commit()
    db.refresh(db_test)
    print('sssssssssssssssssssssssssssssss')
    print(vars(db_test))
    return db_test

@app.get("/tests/{test_id}", response_model=schemas.TestResponse)
def get_test(test_id: int, db: Session = Depends(get_db)):
  
    test = db.query(models.Test).filter(models.Test.id == test_id).first()
    if not test:
        raise HTTPException(status_code=404, detail="Test not found")
    
    return test

@app.post("/tests/{test_id}/submit", response_model=schemas.TestResult)
def submit_test_answers(
    test_id: int,
    answers: schemas.TestSubmission,
    db: Session = Depends(get_db)
):
    
    # Get the test
    test = db.query(models.Test).filter(models.Test.id == test_id).first()
    if not test:
        raise HTTPException(status_code=404, detail="Test not found")
    
    if test.completed:
        raise HTTPException(status_code=400, detail="Test already completed")
    
    correct_count = 0
    
    # Process each answer
    for answer in answers.answers:
        # Get the test question
        test_question = db.query(models.TestQuestion).filter(
            models.TestQuestion.test_id == test_id,
            models.TestQuestion.question_id == answer.question_id
        ).first()
        
        if not test_question:
            continue  # Skip if question not found in this test
        
        # Get the correct answer for this question
        correct_option = db.query(models.AnswerOption).filter(
            models.AnswerOption.question_id == answer.question_id,
            models.AnswerOption.is_correct == True
        ).first()
        
        # Check if answer is correct
        is_correct = (correct_option and correct_option.id == answer.selected_option_id)
        
        if is_correct:
            correct_count += 1
        
        # Update test question with user's answer
        test_question.user_selected_option_id = answer.selected_option_id
        test_question.is_correct = is_correct
    
    # Calculate score
    total_questions = len(answers.answers)
    score = (correct_count / total_questions) * 100 if total_questions > 0 else 0
    
    # Update test completion
    test.completed = True
    test.score = score
    test.completed_at = datetime.utcnow()
    
    db.commit()
    
    # Return results
    return {
        "test_id": test_id,
        "score": round(score, 2),
        "total_questions": total_questions,
        "correct_answers": correct_count,
        "submitted_at": test.completed_at
    }