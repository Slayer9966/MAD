from fastapi import APIRouter, HTTPException, Depends, Form
from sqlalchemy.orm import Session
from models.QA import Question, Answer
from models.user import User
from database import get_db
from dependencies import get_current_user  # <— import this

router = APIRouter()

# POST: Create a question
@router.post("/lessons/{lesson_id}/questions/")
async def create_question(
    lesson_id: int,
    content: str = Form(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Enforce student role
    if current_user.role != "student":
        raise HTTPException(status_code=403, detail="Only students can ask questions.")

    question = Question(
        lesson_id=lesson_id,
        content=content,
        user_id=current_user.id
    )
    db.add(question)
    db.commit()
    db.refresh(question)

    return {
        "message": "Question posted successfully",
        "question_id": question.id,
        "content": question.content,
        "asked_by_user_id": question.user_id
    }

# POST: Create an answer
@router.post("/questions/{question_id}/answers/")
async def create_answer(
    question_id: int,
    content: str = Form(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Enforce tutor role
    if current_user.role != "tutor":
        raise HTTPException(status_code=403, detail="Only tutors can answer questions.")

    question = db.query(Question).filter(Question.id == question_id).first()
    if not question:
        raise HTTPException(status_code=404, detail="Question not found")

    answer = Answer(
        question_id=question_id,
        content=content,
        user_id=current_user.id
    )
    db.add(answer)
    db.commit()
    db.refresh(answer)

    return {
        "message": "Answer posted successfully",
        "answer_id": answer.id,
        "content": answer.content,
        "answered_by_user_id": answer.user_id
    }

# GET: Get all questions + answers for a lesson
@router.get("/lessons/{lesson_id}/qa/")
async def get_qa_for_lesson(lesson_id: int, db: Session = Depends(get_db)):
    questions = db.query(Question).filter(Question.lesson_id == lesson_id).all()
    if not questions:
        raise HTTPException(status_code=404, detail="No questions found for this lesson.")

    qa_data = []
    for q in questions:
        answers = db.query(Answer).filter(Answer.question_id == q.id).all()
        qa_data.append({
            "question_id": q.id,
            "question": q.content,
            "asked_by_user_id": q.user_id,
            "answers": [
                {
                    "answer_id": a.id,
                    "answer_content": a.content,
                    "answered_by_user_id": a.user_id
                }
                for a in answers
            ]
        })

    return {"qa_data": qa_data}
