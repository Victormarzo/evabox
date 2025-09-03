from pydantic import BaseModel, ConfigDict
from typing import List, Optional

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

class TestConfig(BaseModel):
    num_questions: int = 10
    subject_id: Optional[int] = None
    topic_id: Optional[int] = None

class TestQuestionResponse(BaseModel):
    id: int
    name: str
    answer_options: List[AnswerOptionResponse]
    
    model_config = ConfigDict(from_attributes=True)

class TestResponse(BaseModel):
    id: int
    num_questions: int
    subject_id: Optional[int] = None
    topic_id: Optional[int] = None
    questions: List[TestQuestionResponse]
    
    model_config = ConfigDict(from_attributes=True)

class QuestionAnswer(BaseModel):
    question_id: int
    selected_option_id: int

class TestSubmission(BaseModel):
    answers: List[QuestionAnswer]

class TestResult(BaseModel):
    test_id: int
    score: float
    total_questions: int
    correct_answers: int
