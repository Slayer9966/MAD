from fastapi import FastAPI, HTTPException
from routes import auth,login_auth,course, QA
from database import engine, SessionLocal, Base
from models.user import User
from routes import micro_lesson


# Create the tables in the database if they don't exist
Base.metadata.create_all(bind=engine)

# Create FastAPI instance
app = FastAPI()

# Include auth routes
app.include_router(auth.router)
app.include_router(login_auth.router)
app.include_router(course.router)  # Include the course route
app.include_router(micro_lesson.router)
app.include_router(QA.router, prefix="/qa", tags=["Q&A"])  


# Health check route to test DB connection
@app.get("/health")
def health_check():
    db = SessionLocal()
    try:
        # Try to query the first user from the User table
        db_user = db.query(User).first()
        if db_user:
            return {"msg": "Database connected successfully!", "user": db_user.email}
        else:
            return {"msg": "Database is connected, but no users found!"}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Database connection failed")
    finally:
        db.close()
