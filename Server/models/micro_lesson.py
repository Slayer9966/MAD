from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class MicroLesson(Base):
    __tablename__ = "micro_lessons"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    content_type = Column(String, nullable=False)  # 'text', 'pdf', 'image'
    content_path = Column(String, nullable=False)  # file path or text content
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)

    course = relationship("Course", back_populates="micro_lessons")
    questions = relationship("Question", back_populates="lesson")  # <-- Correctly defines relationship with Question
