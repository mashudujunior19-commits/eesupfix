from typing_extensions import Unpack
from pydantic import BaseModel, ConfigDict, Field, EmailStr


class AuthSchema(BaseModel):
    email:str = Field()
    password: str = Field()