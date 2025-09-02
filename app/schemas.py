from pydantic import BaseModel, ConfigDict
from typing import List

class SubjectBase(BaseModel):
    name: str

class TopicBase(BaseModel):
    name: str

class QuestionBase(BaseModel):
    text: str

class AnswerOptionBase(BaseModel):
    text: str
    is_correct: bool

class AnswerOptionCreate(AnswerOptionBase):
    pass

class QuestionCreate(QuestionBase):
    subject_id: int
    topic_id: int
    answer_options: List[AnswerOptionCreate] = []

class TopicCreate(TopicBase):
    subject_id: int

class SubjectCreate(SubjectBase):
    pass

class AnswerOptionResponse(AnswerOptionBase):
    id: int
    question_id: int
    
    model_config = ConfigDict(from_attributes=True)

class QuestionResponse(QuestionBase):
    id: int
    subject_id: int
    topic_id: int
    answer_options: List[AnswerOptionResponse] = []
    
    model_config = ConfigDict(from_attributes=True)

class TopicResponse(TopicBase):
    id: int
  
    model_config = ConfigDict(from_attributes=True)

class TopicDetailResponse(TopicBase):
    id: int
    subject_id: int
    
    model_config = ConfigDict(from_attributes=True)

class SubjectDetailResponse(SubjectBase):
    id: int
    topics: List[TopicResponse] = []
    
    model_config = ConfigDict(from_attributes=True)

class SubjectResponse(SubjectBase):
    id:int

    model_config = ConfigDict(from_attributes=True)