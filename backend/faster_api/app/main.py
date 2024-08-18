from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes.payments import payments_router

app = FastAPI()
app.add_middleware(
    CORSMiddleware, allow_origins=["*"], allow_credentials=True, allow_methods=["*"]
)
app.include_router(payments_router, tags=["payments"])


@app.get("/")
def home():
    return {"Hello": "world"}
