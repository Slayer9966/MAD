from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Course(Base):
    __tablename__ = 'courses'
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    description = Column(String)
    cover_image = Column(String, nullable=True)  # <-- New
    tutor_id = Column(Integer, ForeignKey('users.id'))

    tutor = relationship("User", back_populates="courses")
    # In models/course.py
    micro_lessons = relationship("MicroLesson", back_populates="course", cascade="all, delete-orphan")

