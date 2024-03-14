// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MerchantTransactionImpl _$$MerchantTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$MerchantTransactionImpl(
      mUuid: json['m_uuid'] as String,
      mAccountUuid: json['m_account_uuid'] as String,
      mTxOrderNr: json['m_tx_order_nr'] as String,
      mTxId: json['m_tx_id'] as String,
      mTxCurrency: json['m_tx_currency'] as String,
      mTxAmount: json['m_tx_amount'] as String,
      mTxItemName: json['m_tx_item_name'] as String,
      mTxItemDescription: json['m_tx_item_description'] as String,
      mMessage: json['m_message'] as String?,
      mCategory1: json['m_category_1'] as String?,
      mCategory2: json['m_category_2'] as String?,
      mCategory3: json['m_category_3'] as String?,
      mSiteName: json['m_site_name'] as String?,
      mSiteReference: json['m_site_reference'] as String?,
      mCardAllowed: json['m_card_allowed'] as bool?,
      mEftAllowed: json['m_ieft_allowed'] as bool?,
      mPassAllowed: json['m_pass_allowed'] as bool?,
      mChipsAllowed: json['m_chips_allowed'] as bool?,
      mTridentAllowed: json['m_trident_allowed'] as bool?,
      mPayatAllowed: json['m_payat_allowed'] as bool?,
      bName: json['b_name'] as String?,
      bSurname: json['b_surname'] as String?,
      bEmail: json['b_email'] as String?,
      bMobile: json['b_mobile'] as String?,
      mTxInvoiceNr: json['m_tx_invoice_nr'] as String?,
      mTxDocumentRef: json['m_tx_document_ref'] as String?,
      mTxDueDate: json['m_tx_due_date'] as String?,
      mReturnUrl: json['m_return_url'] as String?,
      mCancelUrl: json['m_cancel_url'] as String?,
      mPendingUrl: json['m_pending_url'] as String?,
      mNotifyUrl: json['m_notify_url'] as String?,
      mBack2shopUrl: json['m_back2shop_url'] as String?,
      mEmailAddress: json['m_email_address'] as String?,
      futureUse: json['future_use'] as String?,
      secret: json['secret'] as String,
    );

Map<String, dynamic> _$$MerchantTransactionImplToJson(
        _$MerchantTransactionImpl instance) =>
    <String, dynamic>{
      'm_uuid': instance.mUuid,
      'm_account_uuid': instance.mAccountUuid,
      'm_tx_order_nr': instance.mTxOrderNr,
      'm_tx_id': instance.mTxId,
      'm_tx_currency': instance.mTxCurrency,
      'm_tx_amount': instance.mTxAmount,
      'm_tx_item_name': instance.mTxItemName,
      'm_tx_item_description': instance.mTxItemDescription,
      'm_message': instance.mMessage,
      'm_category_1': instance.mCategory1,
      'm_category_2': instance.mCategory2,
      'm_category_3': instance.mCategory3,
      'm_site_name': instance.mSiteName,
      'm_site_reference': instance.mSiteReference,
      'm_card_allowed': instance.mCardAllowed,
      'm_ieft_allowed': instance.mEftAllowed,
      'm_pass_allowed': instance.mPassAllowed,
      'm_chips_allowed': instance.mChipsAllowed,
      'm_trident_allowed': instance.mTridentAllowed,
      'm_payat_allowed': instance.mPayatAllowed,
      'b_name': instance.bName,
      'b_surname': instance.bSurname,
      'b_email': instance.bEmail,
      'b_mobile': instance.bMobile,
      'm_tx_invoice_nr': instance.mTxInvoiceNr,
      'm_tx_document_ref': instance.mTxDocumentRef,
      'm_tx_due_date': instance.mTxDueDate,
      'm_return_url': instance.mReturnUrl,
      'm_cancel_url': instance.mCancelUrl,
      'm_pending_url': instance.mPendingUrl,
      'm_notify_url': instance.mNotifyUrl,
      'm_back2shop_url': instance.mBack2shopUrl,
      'm_email_address': instance.mEmailAddress,
      'future_use': instance.futureUse,
      'secret': instance.secret,
    };
