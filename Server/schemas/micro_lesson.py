from pydantic import BaseModel
from typing import Optional

class MicroLessonCreate(BaseModel):
    title: str
    content_type: str  # "text", "pdf", "image"
    text_content: Optional[str] = None  # Only for text-based lessons

class MicroLessonResponse(BaseModel):
    id: int
    title: str
    content_type: str
    content_path: Optional[str] = None
    course_id: int

    class Config:
        orm_mode = True
