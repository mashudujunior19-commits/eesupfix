"""docstring"""

import hashlib
from datetime import datetime

import requests
from fastapi import HTTPException, status

from app.src.payments.models import OzowRequest
from app.src.security import auth
from app.src.supabase_settings import supabase_client, env_config


def generate_hash(params: OzowRequest):
    ozow_site_code = env_config["OZOW_SITE_CODE"]
    ozow_private_key = env_config["OZOW_SITE_CODE"]

    payment = {
        "site_code": ozow_site_code,
        "amount": params.amount,
        "transaction_id": params.transactionReference,
        "bank_ref": "",
        "optional1": None,
        "optional2": params.api_key,
        "optional3": params.paymentType,
        "optional4": None,
        "optional5": None,
        "cancel_url": None,
        "error_url": None,
        "success_url": None,
        "notify_url": "https://notify.url",
        "is_test": "true",
        "private_key": ozow_private_key,
    }

    if payment["success_url"] is None:
        payment["success_url"] = payment["notify_url"]
    if payment["cancel_url"] is None:
        payment["cancel_url"] = payment["notify_url"]
    if payment["error_url"] is None:
        payment["error_url"] = payment["notify_url"]

    country_code = "ZA"
    currency_code = "ZAR"

    hash_str = (
        f"{payment['site_code']}{country_code}{currency_code}"
        f"{payment['amount']:.2f}{payment['transaction_id']}{payment['bank_ref']}"
    )

    # Add optional fields if they are not null
    optional_fields = [
        payment.get("optional1"),
        payment.get("optional2"),
        payment.get("optional3"),
        payment.get("optional4"),
        payment.get("optional5"),
    ]
    for optional_field in optional_fields:
        if optional_field is not None:
            hash_str += optional_field

    # Add URL fields if they are not null
    url_fields = [
        payment.get("cancel_url"),
        payment.get("error_url"),
        payment.get("success_url"),
        payment.get("notify_url"),
    ]
    for url_field in url_fields:
        if url_field is not None:
            hash_str += url_field

    # Add isTest and privateKey at the end
    hash_str += f"{payment['is_test']}{payment['private_key']}"

    # Convert the above concatenated string to lowercase
    hash_str = hash_str.lower()

    # Generate a SHA512 hash of the lowercase concatenated string
    hash_bytes = hash_str.encode("utf-8")
    hash_result = hashlib.sha512(hash_bytes).hexdigest()

    return hash_result


def process_ozow_notification(params: OzowRequest):
    """"""
    try:
        key = auth.fetch_auth_api_key(params.api_key)
        if key is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid or missing API KEY",
            )

        # regenerate hash
        gen_hash = generate_hash(params)
        if gen_hash != params.hash:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid hash"
            )

        ozow_key = env_config["OZOW_API_KEY"]
        ozow_site_code = env_config["OZOW_SITE_CODE"]

        # fetch ozow transaction
        base_url = "https://api.ozow.com/GetTransactionByReference"
        url = f"{base_url}?siteCode={ozow_site_code}&transactionReference={params.transactionReference}&IsTest={params.isTest}"

        res = requests.get(url, headers={"ApiKey": ozow_key}, timeout=20)
        trans = res.json()

        if res.status_code != 200:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Transaction unverified"
            )

        amount = float(trans[0]["amount"])
        trans_status = trans[0]["status"]

        if amount != params.amount | trans_status != params.status:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Unexpected transaction format",
            )

        allowed_statuses = ["Complete", "Cancelled", "Pending"]

        if allowed_statuses.count(trans_status) > 0:
            count = (
                supabase_client()
                .schema("finances")
                .table("online_payment")
                .update(
                    {
                        "confirmed_at": datetime.now().strftime(
                            "%Y-%m-%d %H:%M:%S.%f+00"
                        ),
                        "status": trans_status,
                    }
                )
                .eq("reference_id", params.transactionReference)
                .eq("type", params.paymentType)
                .execute()
            )
            # return {
            #     'status_code': status.HTTP_200_OK,
            #     'detail': count}
        else:
            count = (
                supabase_client()
                .schema("finances")
                .table("online_payment")
                .update(
                    {
                        "confirmed_at": datetime.now().strftime(
                            "%Y-%m-%d %H:%M:%S.%f+00"
                        ),
                        "status": "Pending",
                    }
                )
                .eq("reference_id", params.transactionReference)
                .eq("type", params.paymentType)
                .execute()
            )
            return {"status_code": status.HTTP_200_OK, "detail": count}
    except:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="")
