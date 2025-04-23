from fastapi import APIRouter, HTTPException, Depends
from models.user import User
from schemas.login_auth import LoginRequest
from passlib.context import CryptContext
from sqlalchemy.orm import Session
from database import SessionLocal

router = APIRouter()

# Initialize password hashing context (bcrypt)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Dependency to get the DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/login/")
async def login(login_request: LoginRequest, db: Session = Depends(get_db)):
    # Fetch user from the database by email
    user = db.query(User).filter(User.email == login_request.email).first()

    # Check if user exists and password is correct
    if user is None or not pwd_context.verify(login_request.password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    # You can return some kind of token or success message here
    # If you're not using JWT for now, just return a success message
    return {"message": "Login successful"}
