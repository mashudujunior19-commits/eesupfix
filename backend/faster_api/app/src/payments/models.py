from pydantic import BaseModel, Field


class OzowRequest(BaseModel):
    """
    Given by ozow through query params
    """

    transactionReference: int = Field(alias="TransactionReference")
    amount: float = Field(alias="Amount")
    isTest: bool = Field(alias="IsTest")
    status: str = Field(alias="Status")
    hash: str = Field(alias="Hash")
    api_key: str = Field(
        alias="Optional2", description="EESUp auth key, passed from the app"
    )
    paymentType: str = Field(alias="Optional3")
