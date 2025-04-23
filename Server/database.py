from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# SQLite Database URL
SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

# Create an engine instance
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

# Create session local class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class for model declarations
Base = declarative_base()

# Dependency to get session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
