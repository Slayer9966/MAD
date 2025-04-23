from fastapi import APIRouter, HTTPException, Depends, File, UploadFile, Form
from sqlalchemy.orm import Session
import os
import shutil
from database import get_db
from models.course import Course
from models.micro_lesson import MicroLesson

router = APIRouter()

@router.post("/courses/{course_id}/micro-lessons/")
async def upload_micro_lesson(
    course_id: int,
    title: str = Form(...),
    content_type: str = Form(...),  # 'text', 'pdf', 'image'
    content: UploadFile = File(None),  # For file uploads (PDF/Image)
    text_content: str = Form(None),    # For text-based lessons
    db: Session = Depends(get_db)
):
    # Check if the course exists
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    uploads_dir = "uploads/micro_lessons"
    os.makedirs(uploads_dir, exist_ok=True)

    content_path = None

    # Validate content_type
    if content_type not in ["text", "pdf", "image"]:
        raise HTTPException(status_code=400, detail="Unsupported content type. Must be 'text', 'pdf', or 'image'.")

    # Handling content based on content_type
    if content_type in ["pdf", "image"]:
        if not content:
            raise HTTPException(status_code=400, detail="File content missing for PDF/Image type")
        
        # Ensure the uploaded file has a valid extension
        if content_type == "pdf" and not content.filename.endswith(".pdf"):
            raise HTTPException(status_code=400, detail="Invalid file type. Only PDF files are allowed.")
        elif content_type == "image" and not content.filename.endswith((".png", ".jpg", ".jpeg")):
            raise HTTPException(status_code=400, detail="Invalid file type. Only image files are allowed.")
        
        # Save the uploaded file
        file_path = os.path.join(uploads_dir, content.filename)
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(content.file, buffer)
        content_path = file_path

    elif content_type == "text":
        if not text_content:
            raise HTTPException(status_code=400, detail="Text content missing for text type")
        content_path = text_content

    # Create the micro lesson record
    micro_lesson = MicroLesson(
        title=title,
        content_type=content_type,
        content_path=content_path,
        course_id=course_id
    )

    db.add(micro_lesson)
    db.commit()
    db.refresh(micro_lesson)

    return {
        "message": "Micro-lesson uploaded successfully",
        "micro_lesson_id": micro_lesson.id,
        "title": micro_lesson.title,
        "content_type": micro_lesson.content_type,
        "content_path": micro_lesson.content_path  # Returning the path to the content (could be file or text)
    }
