from fastapi import FastAPI, HTTPException
from routes.payments import payments_router
from dotenv import load_dotenv


app = FastAPI()
load_dotenv('.env')

app.include_router(payments_router,tags=['payments'])


@app.get('/')
def home():
    return {'Hello':'world'}