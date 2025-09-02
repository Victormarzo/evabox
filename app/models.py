from sqlalchemy import Column, Integer, String, ForeignKey, Boolean
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
 