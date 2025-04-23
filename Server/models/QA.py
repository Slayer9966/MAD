from sqlalchemy import Column, Integer, String, Text, ForeignKey
from sqlalchemy.orm import relationship
from database import Base
from models.micro_lesson import MicroLesson

class Question(Base):
    __tablename__ = 'questions'

    id = Column(Integer, primary_key=True, index=True)
    lesson_id = Column(Integer, ForeignKey('micro_lessons.id'))  # ForeignKey still points to table name
    content = Column(Text, nullable=False)
    user_id = Column(Integer, ForeignKey('users.id'))

    lesson = relationship("MicroLesson", back_populates="questions")  # Class name here
    user = relationship("User", back_populates="questions")
    answers = relationship("Answer", back_populates="question")


class Answer(Base):
    __tablename__ = 'answers'

    id = Column(Integer, primary_key=True, index=True)
    question_id = Column(Integer, ForeignKey('questions.id'), nullable=False)
    content = Column(Text, nullable=False)
    user_id = Column(Integer, ForeignKey('users.id'))

    question = relationship("Question", back_populates="answers")
    user = relationship("User", back_populates="answers")
