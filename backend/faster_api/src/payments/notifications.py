"""Docstring"""
import os
import requests
from fastapi import BackgroundTasks
from src.payments.models import OzowRequest
from src.security import auth
from supabase_settings import supabase_client



def generate_hash(params: OzowRequest) -> str:
    # regenerates the ozow hash to verify the incoming payment data
    ###

    return ''


def ozow_notification_task(params: OzowRequest):
    ''''''
    key = auth.fetch_auth_api_key(params.api_key)

    if key is not None:
        # regenerate hash
        gen_hash = generate_hash(params)

        if gen_hash == params.hash:
            # fetch ozow transaction
            ozow_key = os.getenv('OZOW_API_KEY')
            ozow_site_code = os.getenv('OZOW_API_KEY')
            baseUrl = 'https://api.ozow.com/GetTransactionByReference'
            url = '{baseUrl}?siteCode={ozow_site_code}&transactionReference={params.transactionReference}&IsTest={params.isTest}'

            res = requests.get(url, headers={'ApiKey': ozow_key})

            if res.status_code == 200:
                amount = float(res.json['amount'])
                status = res.json['status']

                if status == params.status == 'Complete' & amount == params.amount:
                    supabase_client.schema('').table('').update({''})
                elif status == '':
                    supabase_client.schema('').table('').update({})


def handle_ozow_notification(params: OzowRequest):
    # check api key
    # on success add task
    bg_tasks = BackgroundTasks()
    bg_tasks.add_task(ozow_notification_task, params)
