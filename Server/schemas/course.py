# schemas/course.py

from pydantic import BaseModel
from typing import Optional

class CourseBase(BaseModel):
    title: str
    description: str
    cover_image: Optional[str]  # Optional: Image file name

class CourseCreate(CourseBase):
    pass

class CourseResponse(CourseBase):
    id: int
    tutor_id: int

    class Config:
        orm_mode = True
