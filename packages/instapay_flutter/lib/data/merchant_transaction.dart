// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'merchant_transaction.freezed.dart';
part 'merchant_transaction.g.dart';

@freezed
class MerchantTransaction with _$MerchantTransaction {
  factory MerchantTransaction({
    @JsonKey(name: 'm_uuid') required String mUuid,
    @JsonKey(name: 'm_account_uuid') required String mAccountUuid,
    @JsonKey(name: 'm_tx_order_nr') required String mTxOrderNr,
    @JsonKey(name: 'm_tx_id') required String mTxId,
    @JsonKey(name: 'm_tx_currency') required String mTxCurrency,
    @JsonKey(name: 'm_tx_amount') required String mTxAmount,
    @JsonKey(name: 'm_tx_item_name') required String mTxItemName,
    @JsonKey(name: 'm_tx_item_description') required String mTxItemDescription,
    @JsonKey(name: 'm_message') String? mMessage,
    @JsonKey(name: 'm_category_1') String? mCategory1,
    @JsonKey(name: 'm_category_2') String? mCategory2,
    @JsonKey(name: 'm_category_3') String? mCategory3,
    @JsonKey(name: 'm_site_name') String? mSiteName,
    @JsonKey(name: 'm_site_reference') String? mSiteReference,
    @JsonKey(name: 'm_card_allowed') bool? mCardAllowed,
    @JsonKey(name: 'm_ieft_allowed') bool? mEftAllowed,
    @JsonKey(name: 'm_pass_allowed') bool? mPassAllowed,
    @JsonKey(name: 'm_chips_allowed') bool? mChipsAllowed,
    @JsonKey(name: 'm_trident_allowed') bool? mTridentAllowed,
    @JsonKey(name: 'm_payat_allowed') bool? mPayatAllowed,
    @JsonKey(name: 'b_name') String? bName,
    @JsonKey(name: 'b_surname') String? bSurname,
    @JsonKey(name: 'b_email') String? bEmail,
    @JsonKey(name: 'b_mobile') String? bMobile,
    @JsonKey(name: 'm_tx_invoice_nr') String? mTxInvoiceNr,
    @JsonKey(name: 'm_tx_document_ref') String? mTxDocumentRef,
    @JsonKey(name: 'm_tx_due_date') String? mTxDueDate,
    @JsonKey(name: 'm_return_url') String? mReturnUrl,
    @JsonKey(name: 'm_cancel_url') String? mCancelUrl,
    @JsonKey(name: 'm_pending_url') String? mPendingUrl,
    @JsonKey(name: 'm_notify_url') String? mNotifyUrl,
    @JsonKey(name: 'm_back2shop_url') String? mBack2shopUrl,
    @JsonKey(name: 'm_email_address') String? mEmailAddress,
    @JsonKey(name: 'future_use') String? futureUse,
    required  String secret,
  }) = _MerchantTransaction;

  factory MerchantTransaction.fromJson(Map<String, dynamic> json) =>
      _$MerchantTransactionFromJson(json);
}
