# dependencies.py
from fastapi import Depends, Header, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models.user import User

async def get_current_user(
    x_user_id: int = Header(..., alias="X-User-Id"),
    db: Session = Depends(get_db)
) -> User:
    """
    Fetch the current user by the integer ID passed in the X-User-Id header.
    """
    user = db.query(User).filter(User.id == x_user_id).first()
    if not user:
        raise HTTPException(status_code=401, detail="Invalid X-User-Id header")
    return user
