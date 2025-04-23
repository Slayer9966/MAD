from pydantic import BaseModel
from typing import List, Optional

# ------------------------
# Base Schemas
# ------------------------

class QuestionBase(BaseModel):
    content: str
    lesson_id: int

class AnswerBase(BaseModel):
    content: str
    question_id: int

# ------------------------
# Create Schemas
# ------------------------

class QuestionCreate(QuestionBase):
    pass  # Same as QuestionBase for now

class AnswerCreate(AnswerBase):
    pass  # Same as AnswerBase for now

# ------------------------
# Response Schemas
# ------------------------

class AnswerResponse(BaseModel):
    id: int
    content: str
    user_id: int

    class Config:
        orm_mode = True

class QuestionResponse(BaseModel):
    id: int
    content: str
    user_id: int
    lesson_id: int
    answers: List[AnswerResponse] = []  # a list of answers under each question

    class Config:
        orm_mode = True
