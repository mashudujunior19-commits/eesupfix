import time
from typing import Dict
from app.services.auth.model import AuthSchema

import jwt
from decouple import config

class AuthService:
    JWT_SECRET = 'qwertyuiopasdfgh'
    JWT_ALGORITHM = 'HS256'
    

    def sign_jwt(self, auth: AuthSchema):
        print('')


    def login(self, auth:AuthSchema):
        #TODO: fetch user

        #TODO: sign token

        return self.sign_jwt()

    