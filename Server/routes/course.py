from fastapi import APIRouter, HTTPException, Depends, File, UploadFile, Form
from sqlalchemy.orm import Session
from database import get_db
from models.course import Course
import shutil
import os
from models.user import User
import time

router = APIRouter()

@router.post("/courses/{tutor_id}/")
async def create_course(
    tutor_id: int,  # Tutor ID comes from the URL
    title: str = Form(...),
    description: str = Form(...),
    cover_image: UploadFile = File(...),  # This will handle the uploaded file
    db: Session = Depends(get_db)
):
    # Check if the user is a tutor
    tutor = db.query(User).filter(User.id == tutor_id).first()
    if not tutor or tutor.role != "tutor":
        raise HTTPException(status_code=403, detail="Only tutors can create courses")

    # Validate the cover image file type
    allowed_image_extensions = ["jpg", "jpeg", "png", "gif"]
    cover_image_extension = cover_image.filename.split('.')[-1].lower()
    if cover_image_extension not in allowed_image_extensions:
        raise HTTPException(status_code=400, detail="Invalid cover image file type. Only image files are allowed")

    # Save the cover image
    uploads_dir = "uploads"
    os.makedirs(uploads_dir, exist_ok=True)
    cover_image_path = os.path.join(uploads_dir, f"{int(time.time())}_{cover_image.filename}")
    with open(cover_image_path, "wb") as buffer:
        shutil.copyfileobj(cover_image.file, buffer)

    # Add the new course to the database (no PDF handling here anymore)
    new_course = Course(
        title=title,
        description=description,
        cover_image=cover_image.filename,  # Save the image filename
        tutor_id=tutor_id  # Use the tutor ID from the URL
    )
    db.add(new_course)
    db.commit()
    db.refresh(new_course)

    return {"message": "Course created successfully", "course_id": new_course.id}
