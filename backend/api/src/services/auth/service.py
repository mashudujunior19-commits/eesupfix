import datetime

from fastapi import FastAPI, HTTPException, Depends, Security
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm, HTTPBearer, HTTPAuthorizationCredentials
from jose import jwt
from passlib.context import CryptContext


SECRET_KEY = "your_long_and_strong_secret_key"  # Keep this secret!
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

class AuthService:
    def __init__(self) -> None:
        pass

    def create_access_token(data: dict, expires_delta: datetime.timedelta | None = None):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.datetime.now() + expires_delta
        else:
            expire = datetime.datetime.now() + datetime.timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt
    
    