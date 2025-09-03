from sqlalchemy import JSON, Float, Column, Integer, String, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from .database import Base

class Subject(Base):
    __tablename__= 'subject'
    id = Column(Integer, primary_key=True, index=True)
    name= Column(String, nullable=False)

    topics = relationship('Topic', back_populates = 'subject')
    questions = relationship('Question', back_populates = 'subject')

class Topic(Base):
    __tablename__= 'topic'

    id = Column(Integer, primary_key=True, index=True)
    name= Column(String, nullable=False)
    subject_id = Column(Integer,ForeignKey('subject.id'))

    subject = relationship('Subject', back_populates = 'topics')
    questions = relationship('Question', back_populates = 'topic')

class Question(Base):
    __tablename__= 'question'

    id = Column(Integer, primary_key=True, index=True)
    text= Column(String, nullable=False)
    subject_id = Column(Integer,ForeignKey('subject.id'))
    topic_id = Column(Integer, ForeignKey('topic.id'))

    subject = relationship('Subject', back_populates = 'questions')
    topic = relationship('Topic', back_populates = 'questions')
    answer_options = relationship('AnswerOption', back_populates = 'question')

class AnswerOption(Base):
    __tablename__= 'answer_option'

    id = Column(Integer, primary_key=True, index=True)
    text= Column(String, nullable=False)
    question_id = Column(Integer,ForeignKey('question.id'))
    is_correct = Column(Boolean, default=False)

    question = relationship('Question', back_populates = 'answer_options')
 
class Test(Base):
    __tablename__ = 'tests'
    
    id = Column(Integer, primary_key=True, index=True)
    num_questions = Column(Integer)
    subject_id = Column(Integer, ForeignKey('subject.id'), nullable=True)
    topic_id = Column(Integer, ForeignKey('topic.id'), nullable=True)
    completed = Column(Boolean, default=False)
    score = Column(Float, nullable=True)
    
    # Relationships
    subject = relationship("Subject")
    topic = relationship("Topic")
    test_questions = relationship("TestQuestion", back_populates="test")

class TestQuestion(Base):
    __tablename__ = 'test_questions'
    
    id = Column(Integer, primary_key=True, index=True)
    test_id = Column(Integer, ForeignKey('tests.id'))
    question_id = Column(Integer, ForeignKey('question.id'))
    user_selected_option_id = Column(Integer, ForeignKey('answer_option.id'), nullable=True)
    is_correct = Column(Boolean, nullable=True)
    
    # Relationships
    test = relationship("Test", back_populates="test_questions")
    question = relationship("Question")
    selected_option = relationship("AnswerOption")