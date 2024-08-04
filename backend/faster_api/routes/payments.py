from fastapi import APIRouter, HTTPException,Depends
from src.payments.models import OzowRequest
from src.payments.notifications import handle_ozow_notification

payments_router = APIRouter()


@payments_router.post('/ozow/notify')
def notify_ozow(params:OzowRequest=Depends()):
    if params.api_key == None:
        return HTTPException(status_code=401, detail='Invalid or missing API KEY')
    else:
        handle_ozow_notification(params)
        return 