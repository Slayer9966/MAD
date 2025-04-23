from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from database import Base

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True, index=True)
    first_name=Column(String, index=True)
    last_name=Column(String,index=True)
    email = Column(String, unique=True, index=True)
    password_hash = Column(String)  # Store hashed password
    role = Column(String, default="student")  # 'student' or 'tutor'
    courses = relationship("Course", back_populates="tutor")
    questions = relationship("Question", back_populates="user")
    answers = relationship("Answer", back_populates="user")