import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.main import app
from app.database import get_db, Base

TEST_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(TEST_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

@pytest.fixture(scope="function")
def db_session():
    Base.metadata.create_all(bind=engine)
    session = TestingSessionLocal()
    
    yield session
    
    session.close()
    Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="function")
def client(db_session):
    def override_get_db():
        try:
            yield db_session
        finally:
            pass
    
    app.dependency_overrides[get_db] = override_get_db
    
    with TestClient(app) as test_client:
        yield test_client
    
    app.dependency_overrides.clear()

@pytest.fixture
def subject(db_session):
    from app import models
    subject = models.Subject(name="Mathematics")
    db_session.add(subject)
    db_session.commit()
    db_session.refresh(subject)
    return subject

@pytest.fixture
def topic(db_session, subject):
    from app import models
    topic = models.Topic(name="Algebra", subject_id=subject.id)
    db_session.add(topic)
    db_session.commit()
    db_session.refresh(topic)
    return topic

@pytest.fixture
def question(db_session, subject, topic):
    from app import models
    question = models.Question(
        name="What is 2+2?", 
        subject_id=subject.id, 
        topic_id=topic.id
    )
    db_session.add(question)
    db_session.commit()
    db_session.refresh(question)
    
    option1 = models.AnswerOption(
        text="4", is_correct=True, question_id=question.id
    )
    option2 = models.AnswerOption(
        text="5", is_correct=False, question_id=question.id
    )
    db_session.add_all([option1, option2])
    db_session.commit()
    db_session.refresh(question)
    return question