from pydantic import BaseModel
from typing import Optional

# Pydantic schema for user registration
class UserCreate(BaseModel):
    first_name: str
    last_name: str
    email: str
    password: str
    role: Optional[str] = "student"  # Default is 'student'

    class Config:
        orm_mode = True

