from fastapi import APIRouter, Depends
from app.src.payments.models import OzowRequest
from app.src.payments.notifications import process_ozow_notification

payments_router = APIRouter()


@payments_router.post("/ozow/notify")
def notify_ozow(params: OzowRequest = Depends()):
    return process_ozow_notification(params)
