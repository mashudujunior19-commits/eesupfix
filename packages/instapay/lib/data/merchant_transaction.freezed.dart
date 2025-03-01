// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MerchantTransaction {
  @JsonKey(name: 'm_uuid')
  String get mUuid;
  @JsonKey(name: 'm_account_uuid')
  String get mAccountUuid;
  @JsonKey(name: 'm_tx_order_nr')
  String get mTxOrderNr;
  @JsonKey(name: 'm_tx_id')
  String get mTxId;
  @JsonKey(name: 'm_tx_currency')
  String get mTxCurrency;
  @JsonKey(name: 'm_tx_amount')
  String get mTxAmount;
  @JsonKey(name: 'm_tx_item_name')
  String get mTxItemName;
  @JsonKey(name: 'm_tx_item_description')
  String get mTxItemDescription;
  @JsonKey(name: 'm_message')
  String? get mMessage;
  @JsonKey(name: 'm_category_1')
  String? get mCategory1;
  @JsonKey(name: 'm_category_2')
  String? get mCategory2;
  @JsonKey(name: 'm_category_3')
  String? get mCategory3;
  @JsonKey(name: 'm_site_name')
  String? get mSiteName;
  @JsonKey(name: 'm_site_reference')
  String? get mSiteReference;
  @JsonKey(name: 'm_card_allowed')
  bool? get mCardAllowed;
  @JsonKey(name: 'm_ieft_allowed')
  bool? get mEftAllowed;
  @JsonKey(name: 'm_pass_allowed')
  bool? get mPassAllowed;
  @JsonKey(name: 'm_chips_allowed')
  bool? get mChipsAllowed;
  @JsonKey(name: 'm_trident_allowed')
  bool? get mTridentAllowed;
  @JsonKey(name: 'm_payat_allowed')
  bool? get mPayatAllowed;
  @JsonKey(name: 'b_name')
  String? get bName;
  @JsonKey(name: 'b_surname')
  String? get bSurname;
  @JsonKey(name: 'b_email')
  String? get bEmail;
  @JsonKey(name: 'b_mobile')
  String? get bMobile;
  @JsonKey(name: 'm_tx_invoice_nr')
  String? get mTxInvoiceNr;
  @JsonKey(name: 'm_tx_document_ref')
  String? get mTxDocumentRef;
  @JsonKey(name: 'm_tx_due_date')
  String? get mTxDueDate;
  @JsonKey(name: 'm_return_url')
  String? get mReturnUrl;
  @JsonKey(name: 'm_cancel_url')
  String? get mCancelUrl;
  @JsonKey(name: 'm_pending_url')
  String? get mPendingUrl;
  @JsonKey(name: 'm_notify_url')
  String? get mNotifyUrl;
  @JsonKey(name: 'm_back2shop_url')
  String? get mBack2shopUrl;
  @JsonKey(name: 'm_email_address')
  String? get mEmailAddress;
  @JsonKey(name: 'future_use')
  String? get futureUse;
  @JsonKey(name: 'sendbox_url')
  String get sendboxUrl;
  String get secret;

  /// Create a copy of MerchantTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MerchantTransactionCopyWith<MerchantTransaction> get copyWith =>
      _$MerchantTransactionCopyWithImpl<MerchantTransaction>(
          this as MerchantTransaction, _$identity);

  /// Serializes this MerchantTransaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MerchantTransaction &&
            (identical(other.mUuid, mUuid) || other.mUuid == mUuid) &&
            (identical(other.mAccountUuid, mAccountUuid) ||
                other.mAccountUuid == mAccountUuid) &&
            (identical(other.mTxOrderNr, mTxOrderNr) ||
                other.mTxOrderNr == mTxOrderNr) &&
            (identical(other.mTxId, mTxId) || other.mTxId == mTxId) &&
            (identical(other.mTxCurrency, mTxCurrency) ||
                other.mTxCurrency == mTxCurrency) &&
            (identical(other.mTxAmount, mTxAmount) ||
                other.mTxAmount == mTxAmount) &&
            (identical(other.mTxItemName, mTxItemName) ||
                other.mTxItemName == mTxItemName) &&
            (identical(other.mTxItemDescription, mTxItemDescription) ||
                other.mTxItemDescription == mTxItemDescription) &&
            (identical(other.mMessage, mMessage) ||
                other.mMessage == mMessage) &&
            (identical(other.mCategory1, mCategory1) ||
                other.mCategory1 == mCategory1) &&
            (identical(other.mCategory2, mCategory2) ||
                other.mCategory2 == mCategory2) &&
            (identical(other.mCategory3, mCategory3) ||
                other.mCategory3 == mCategory3) &&
            (identical(other.mSiteName, mSiteName) ||
                other.mSiteName == mSiteName) &&
            (identical(other.mSiteReference, mSiteReference) ||
                other.mSiteReference == mSiteReference) &&
            (identical(other.mCardAllowed, mCardAllowed) ||
                other.mCardAllowed == mCardAllowed) &&
            (identical(other.mEftAllowed, mEftAllowed) ||
                other.mEftAllowed == mEftAllowed) &&
            (identical(other.mPassAllowed, mPassAllowed) ||
                other.mPassAllowed == mPassAllowed) &&
            (identical(other.mChipsAllowed, mChipsAllowed) ||
                other.mChipsAllowed == mChipsAllowed) &&
            (identical(other.mTridentAllowed, mTridentAllowed) ||
                other.mTridentAllowed == mTridentAllowed) &&
            (identical(other.mPayatAllowed, mPayatAllowed) ||
                other.mPayatAllowed == mPayatAllowed) &&
            (identical(other.bName, bName) || other.bName == bName) &&
            (identical(other.bSurname, bSurname) ||
                other.bSurname == bSurname) &&
            (identical(other.bEmail, bEmail) || other.bEmail == bEmail) &&
            (identical(other.bMobile, bMobile) || other.bMobile == bMobile) &&
            (identical(other.mTxInvoiceNr, mTxInvoiceNr) ||
                other.mTxInvoiceNr == mTxInvoiceNr) &&
            (identical(other.mTxDocumentRef, mTxDocumentRef) ||
                other.mTxDocumentRef == mTxDocumentRef) &&
            (identical(other.mTxDueDate, mTxDueDate) ||
                other.mTxDueDate == mTxDueDate) &&
            (identical(other.mReturnUrl, mReturnUrl) ||
                other.mReturnUrl == mReturnUrl) &&
            (identical(other.mCancelUrl, mCancelUrl) ||
                other.mCancelUrl == mCancelUrl) &&
            (identical(other.mPendingUrl, mPendingUrl) ||
                other.mPendingUrl == mPendingUrl) &&
            (identical(other.mNotifyUrl, mNotifyUrl) ||
                other.mNotifyUrl == mNotifyUrl) &&
            (identical(other.mBack2shopUrl, mBack2shopUrl) ||
                other.mBack2shopUrl == mBack2shopUrl) &&
            (identical(other.mEmailAddress, mEmailAddress) ||
                other.mEmailAddress == mEmailAddress) &&
            (identical(other.futureUse, futureUse) ||
                other.futureUse == futureUse) &&
            (identical(other.sendboxUrl, sendboxUrl) ||
                other.sendboxUrl == sendboxUrl) &&
            (identical(other.secret, secret) || other.secret == secret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        mUuid,
        mAccountUuid,
        mTxOrderNr,
        mTxId,
        mTxCurrency,
        mTxAmount,
        mTxItemName,
        mTxItemDescription,
        mMessage,
        mCategory1,
        mCategory2,
        mCategory3,
        mSiteName,
        mSiteReference,
        mCardAllowed,
        mEftAllowed,
        mPassAllowed,
        mChipsAllowed,
        mTridentAllowed,
        mPayatAllowed,
        bName,
        bSurname,
        bEmail,
        bMobile,
        mTxInvoiceNr,
        mTxDocumentRef,
        mTxDueDate,
        mReturnUrl,
        mCancelUrl,
        mPendingUrl,
        mNotifyUrl,
        mBack2shopUrl,
        mEmailAddress,
        futureUse,
        sendboxUrl,
        secret
      ]);

  @override
  String toString() {
    return 'MerchantTransaction(mUuid: $mUuid, mAccountUuid: $mAccountUuid, mTxOrderNr: $mTxOrderNr, mTxId: $mTxId, mTxCurrency: $mTxCurrency, mTxAmount: $mTxAmount, mTxItemName: $mTxItemName, mTxItemDescription: $mTxItemDescription, mMessage: $mMessage, mCategory1: $mCategory1, mCategory2: $mCategory2, mCategory3: $mCategory3, mSiteName: $mSiteName, mSiteReference: $mSiteReference, mCardAllowed: $mCardAllowed, mEftAllowed: $mEftAllowed, mPassAllowed: $mPassAllowed, mChipsAllowed: $mChipsAllowed, mTridentAllowed: $mTridentAllowed, mPayatAllowed: $mPayatAllowed, bName: $bName, bSurname: $bSurname, bEmail: $bEmail, bMobile: $bMobile, mTxInvoiceNr: $mTxInvoiceNr, mTxDocumentRef: $mTxDocumentRef, mTxDueDate: $mTxDueDate, mReturnUrl: $mReturnUrl, mCancelUrl: $mCancelUrl, mPendingUrl: $mPendingUrl, mNotifyUrl: $mNotifyUrl, mBack2shopUrl: $mBack2shopUrl, mEmailAddress: $mEmailAddress, futureUse: $futureUse, sendboxUrl: $sendboxUrl, secret: $secret)';
  }
}

/// @nodoc
abstract mixin class $MerchantTransactionCopyWith<$Res> {
  factory $MerchantTransactionCopyWith(
          MerchantTransaction value, $Res Function(MerchantTransaction) _then) =
      _$MerchantTransactionCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'm_uuid') String mUuid,
      @JsonKey(name: 'm_account_uuid') String mAccountUuid,
      @JsonKey(name: 'm_tx_order_nr') String mTxOrderNr,
      @JsonKey(name: 'm_tx_id') String mTxId,
      @JsonKey(name: 'm_tx_currency') String mTxCurrency,
      @JsonKey(name: 'm_tx_amount') String mTxAmount,
      @JsonKey(name: 'm_tx_item_name') String mTxItemName,
      @JsonKey(name: 'm_tx_item_description') String mTxItemDescription,
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
      @JsonKey(name: 'sendbox_url') String sendboxUrl,
      String secret});
}

/// @nodoc
class _$MerchantTransactionCopyWithImpl<$Res>
    implements $MerchantTransactionCopyWith<$Res> {
  _$MerchantTransactionCopyWithImpl(this._self, this._then);

  final MerchantTransaction _self;
  final $Res Function(MerchantTransaction) _then;

  /// Create a copy of MerchantTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mUuid = null,
    Object? mAccountUuid = null,
    Object? mTxOrderNr = null,
    Object? mTxId = null,
    Object? mTxCurrency = null,
    Object? mTxAmount = null,
    Object? mTxItemName = null,
    Object? mTxItemDescription = null,
    Object? mMessage = freezed,
    Object? mCategory1 = freezed,
    Object? mCategory2 = freezed,
    Object? mCategory3 = freezed,
    Object? mSiteName = freezed,
    Object? mSiteReference = freezed,
    Object? mCardAllowed = freezed,
    Object? mEftAllowed = freezed,
    Object? mPassAllowed = freezed,
    Object? mChipsAllowed = freezed,
    Object? mTridentAllowed = freezed,
    Object? mPayatAllowed = freezed,
    Object? bName = freezed,
    Object? bSurname = freezed,
    Object? bEmail = freezed,
    Object? bMobile = freezed,
    Object? mTxInvoiceNr = freezed,
    Object? mTxDocumentRef = freezed,
    Object? mTxDueDate = freezed,
    Object? mReturnUrl = freezed,
    Object? mCancelUrl = freezed,
    Object? mPendingUrl = freezed,
    Object? mNotifyUrl = freezed,
    Object? mBack2shopUrl = freezed,
    Object? mEmailAddress = freezed,
    Object? futureUse = freezed,
    Object? sendboxUrl = null,
    Object? secret = null,
  }) {
    return _then(_self.copyWith(
      mUuid: null == mUuid
          ? _self.mUuid
          : mUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mAccountUuid: null == mAccountUuid
          ? _self.mAccountUuid
          : mAccountUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mTxOrderNr: null == mTxOrderNr
          ? _self.mTxOrderNr
          : mTxOrderNr // ignore: cast_nullable_to_non_nullable
              as String,
      mTxId: null == mTxId
          ? _self.mTxId
          : mTxId // ignore: cast_nullable_to_non_nullable
              as String,
      mTxCurrency: null == mTxCurrency
          ? _self.mTxCurrency
          : mTxCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      mTxAmount: null == mTxAmount
          ? _self.mTxAmount
          : mTxAmount // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemName: null == mTxItemName
          ? _self.mTxItemName
          : mTxItemName // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemDescription: null == mTxItemDescription
          ? _self.mTxItemDescription
          : mTxItemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      mMessage: freezed == mMessage
          ? _self.mMessage
          : mMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory1: freezed == mCategory1
          ? _self.mCategory1
          : mCategory1 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory2: freezed == mCategory2
          ? _self.mCategory2
          : mCategory2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory3: freezed == mCategory3
          ? _self.mCategory3
          : mCategory3 // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteName: freezed == mSiteName
          ? _self.mSiteName
          : mSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteReference: freezed == mSiteReference
          ? _self.mSiteReference
          : mSiteReference // ignore: cast_nullable_to_non_nullable
              as String?,
      mCardAllowed: freezed == mCardAllowed
          ? _self.mCardAllowed
          : mCardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mEftAllowed: freezed == mEftAllowed
          ? _self.mEftAllowed
          : mEftAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPassAllowed: freezed == mPassAllowed
          ? _self.mPassAllowed
          : mPassAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mChipsAllowed: freezed == mChipsAllowed
          ? _self.mChipsAllowed
          : mChipsAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mTridentAllowed: freezed == mTridentAllowed
          ? _self.mTridentAllowed
          : mTridentAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPayatAllowed: freezed == mPayatAllowed
          ? _self.mPayatAllowed
          : mPayatAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      bName: freezed == bName
          ? _self.bName
          : bName // ignore: cast_nullable_to_non_nullable
              as String?,
      bSurname: freezed == bSurname
          ? _self.bSurname
          : bSurname // ignore: cast_nullable_to_non_nullable
              as String?,
      bEmail: freezed == bEmail
          ? _self.bEmail
          : bEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bMobile: freezed == bMobile
          ? _self.bMobile
          : bMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxInvoiceNr: freezed == mTxInvoiceNr
          ? _self.mTxInvoiceNr
          : mTxInvoiceNr // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDocumentRef: freezed == mTxDocumentRef
          ? _self.mTxDocumentRef
          : mTxDocumentRef // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDueDate: freezed == mTxDueDate
          ? _self.mTxDueDate
          : mTxDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      mReturnUrl: freezed == mReturnUrl
          ? _self.mReturnUrl
          : mReturnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mCancelUrl: freezed == mCancelUrl
          ? _self.mCancelUrl
          : mCancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mPendingUrl: freezed == mPendingUrl
          ? _self.mPendingUrl
          : mPendingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mNotifyUrl: freezed == mNotifyUrl
          ? _self.mNotifyUrl
          : mNotifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mBack2shopUrl: freezed == mBack2shopUrl
          ? _self.mBack2shopUrl
          : mBack2shopUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mEmailAddress: freezed == mEmailAddress
          ? _self.mEmailAddress
          : mEmailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      futureUse: freezed == futureUse
          ? _self.futureUse
          : futureUse // ignore: cast_nullable_to_non_nullable
              as String?,
      sendboxUrl: null == sendboxUrl
          ? _self.sendboxUrl
          : sendboxUrl // ignore: cast_nullable_to_non_nullable
              as String,
      secret: null == secret
          ? _self.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MerchantTransaction implements MerchantTransaction {
  _MerchantTransaction(
      {@JsonKey(name: 'm_uuid') required this.mUuid,
      @JsonKey(name: 'm_account_uuid') required this.mAccountUuid,
      @JsonKey(name: 'm_tx_order_nr') required this.mTxOrderNr,
      @JsonKey(name: 'm_tx_id') required this.mTxId,
      @JsonKey(name: 'm_tx_currency') required this.mTxCurrency,
      @JsonKey(name: 'm_tx_amount') required this.mTxAmount,
      @JsonKey(name: 'm_tx_item_name') required this.mTxItemName,
      @JsonKey(name: 'm_tx_item_description') required this.mTxItemDescription,
      @JsonKey(name: 'm_message') this.mMessage,
      @JsonKey(name: 'm_category_1') this.mCategory1,
      @JsonKey(name: 'm_category_2') this.mCategory2,
      @JsonKey(name: 'm_category_3') this.mCategory3,
      @JsonKey(name: 'm_site_name') this.mSiteName,
      @JsonKey(name: 'm_site_reference') this.mSiteReference,
      @JsonKey(name: 'm_card_allowed') this.mCardAllowed,
      @JsonKey(name: 'm_ieft_allowed') this.mEftAllowed,
      @JsonKey(name: 'm_pass_allowed') this.mPassAllowed,
      @JsonKey(name: 'm_chips_allowed') this.mChipsAllowed,
      @JsonKey(name: 'm_trident_allowed') this.mTridentAllowed,
      @JsonKey(name: 'm_payat_allowed') this.mPayatAllowed,
      @JsonKey(name: 'b_name') this.bName,
      @JsonKey(name: 'b_surname') this.bSurname,
      @JsonKey(name: 'b_email') this.bEmail,
      @JsonKey(name: 'b_mobile') this.bMobile,
      @JsonKey(name: 'm_tx_invoice_nr') this.mTxInvoiceNr,
      @JsonKey(name: 'm_tx_document_ref') this.mTxDocumentRef,
      @JsonKey(name: 'm_tx_due_date') this.mTxDueDate,
      @JsonKey(name: 'm_return_url') this.mReturnUrl,
      @JsonKey(name: 'm_cancel_url') this.mCancelUrl,
      @JsonKey(name: 'm_pending_url') this.mPendingUrl,
      @JsonKey(name: 'm_notify_url') this.mNotifyUrl,
      @JsonKey(name: 'm_back2shop_url') this.mBack2shopUrl,
      @JsonKey(name: 'm_email_address') this.mEmailAddress,
      @JsonKey(name: 'future_use') this.futureUse,
      @JsonKey(name: 'sendbox_url') required this.sendboxUrl,
      required this.secret});
  factory _MerchantTransaction.fromJson(Map<String, dynamic> json) =>
      _$MerchantTransactionFromJson(json);

  @override
  @JsonKey(name: 'm_uuid')
  final String mUuid;
  @override
  @JsonKey(name: 'm_account_uuid')
  final String mAccountUuid;
  @override
  @JsonKey(name: 'm_tx_order_nr')
  final String mTxOrderNr;
  @override
  @JsonKey(name: 'm_tx_id')
  final String mTxId;
  @override
  @JsonKey(name: 'm_tx_currency')
  final String mTxCurrency;
  @override
  @JsonKey(name: 'm_tx_amount')
  final String mTxAmount;
  @override
  @JsonKey(name: 'm_tx_item_name')
  final String mTxItemName;
  @override
  @JsonKey(name: 'm_tx_item_description')
  final String mTxItemDescription;
  @override
  @JsonKey(name: 'm_message')
  final String? mMessage;
  @override
  @JsonKey(name: 'm_category_1')
  final String? mCategory1;
  @override
  @JsonKey(name: 'm_category_2')
  final String? mCategory2;
  @override
  @JsonKey(name: 'm_category_3')
  final String? mCategory3;
  @override
  @JsonKey(name: 'm_site_name')
  final String? mSiteName;
  @override
  @JsonKey(name: 'm_site_reference')
  final String? mSiteReference;
  @override
  @JsonKey(name: 'm_card_allowed')
  final bool? mCardAllowed;
  @override
  @JsonKey(name: 'm_ieft_allowed')
  final bool? mEftAllowed;
  @override
  @JsonKey(name: 'm_pass_allowed')
  final bool? mPassAllowed;
  @override
  @JsonKey(name: 'm_chips_allowed')
  final bool? mChipsAllowed;
  @override
  @JsonKey(name: 'm_trident_allowed')
  final bool? mTridentAllowed;
  @override
  @JsonKey(name: 'm_payat_allowed')
  final bool? mPayatAllowed;
  @override
  @JsonKey(name: 'b_name')
  final String? bName;
  @override
  @JsonKey(name: 'b_surname')
  final String? bSurname;
  @override
  @JsonKey(name: 'b_email')
  final String? bEmail;
  @override
  @JsonKey(name: 'b_mobile')
  final String? bMobile;
  @override
  @JsonKey(name: 'm_tx_invoice_nr')
  final String? mTxInvoiceNr;
  @override
  @JsonKey(name: 'm_tx_document_ref')
  final String? mTxDocumentRef;
  @override
  @JsonKey(name: 'm_tx_due_date')
  final String? mTxDueDate;
  @override
  @JsonKey(name: 'm_return_url')
  final String? mReturnUrl;
  @override
  @JsonKey(name: 'm_cancel_url')
  final String? mCancelUrl;
  @override
  @JsonKey(name: 'm_pending_url')
  final String? mPendingUrl;
  @override
  @JsonKey(name: 'm_notify_url')
  final String? mNotifyUrl;
  @override
  @JsonKey(name: 'm_back2shop_url')
  final String? mBack2shopUrl;
  @override
  @JsonKey(name: 'm_email_address')
  final String? mEmailAddress;
  @override
  @JsonKey(name: 'future_use')
  final String? futureUse;
  @override
  @JsonKey(name: 'sendbox_url')
  final String sendboxUrl;
  @override
  final String secret;

  /// Create a copy of MerchantTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MerchantTransactionCopyWith<_MerchantTransaction> get copyWith =>
      __$MerchantTransactionCopyWithImpl<_MerchantTransaction>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MerchantTransactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MerchantTransaction &&
            (identical(other.mUuid, mUuid) || other.mUuid == mUuid) &&
            (identical(other.mAccountUuid, mAccountUuid) ||
                other.mAccountUuid == mAccountUuid) &&
            (identical(other.mTxOrderNr, mTxOrderNr) ||
                other.mTxOrderNr == mTxOrderNr) &&
            (identical(other.mTxId, mTxId) || other.mTxId == mTxId) &&
            (identical(other.mTxCurrency, mTxCurrency) ||
                other.mTxCurrency == mTxCurrency) &&
            (identical(other.mTxAmount, mTxAmount) ||
                other.mTxAmount == mTxAmount) &&
            (identical(other.mTxItemName, mTxItemName) ||
                other.mTxItemName == mTxItemName) &&
            (identical(other.mTxItemDescription, mTxItemDescription) ||
                other.mTxItemDescription == mTxItemDescription) &&
            (identical(other.mMessage, mMessage) ||
                other.mMessage == mMessage) &&
            (identical(other.mCategory1, mCategory1) ||
                other.mCategory1 == mCategory1) &&
            (identical(other.mCategory2, mCategory2) ||
                other.mCategory2 == mCategory2) &&
            (identical(other.mCategory3, mCategory3) ||
                other.mCategory3 == mCategory3) &&
            (identical(other.mSiteName, mSiteName) ||
                other.mSiteName == mSiteName) &&
            (identical(other.mSiteReference, mSiteReference) ||
                other.mSiteReference == mSiteReference) &&
            (identical(other.mCardAllowed, mCardAllowed) ||
                other.mCardAllowed == mCardAllowed) &&
            (identical(other.mEftAllowed, mEftAllowed) ||
                other.mEftAllowed == mEftAllowed) &&
            (identical(other.mPassAllowed, mPassAllowed) ||
                other.mPassAllowed == mPassAllowed) &&
            (identical(other.mChipsAllowed, mChipsAllowed) ||
                other.mChipsAllowed == mChipsAllowed) &&
            (identical(other.mTridentAllowed, mTridentAllowed) ||
                other.mTridentAllowed == mTridentAllowed) &&
            (identical(other.mPayatAllowed, mPayatAllowed) ||
                other.mPayatAllowed == mPayatAllowed) &&
            (identical(other.bName, bName) || other.bName == bName) &&
            (identical(other.bSurname, bSurname) ||
                other.bSurname == bSurname) &&
            (identical(other.bEmail, bEmail) || other.bEmail == bEmail) &&
            (identical(other.bMobile, bMobile) || other.bMobile == bMobile) &&
            (identical(other.mTxInvoiceNr, mTxInvoiceNr) ||
                other.mTxInvoiceNr == mTxInvoiceNr) &&
            (identical(other.mTxDocumentRef, mTxDocumentRef) ||
                other.mTxDocumentRef == mTxDocumentRef) &&
            (identical(other.mTxDueDate, mTxDueDate) ||
                other.mTxDueDate == mTxDueDate) &&
            (identical(other.mReturnUrl, mReturnUrl) ||
                other.mReturnUrl == mReturnUrl) &&
            (identical(other.mCancelUrl, mCancelUrl) ||
                other.mCancelUrl == mCancelUrl) &&
            (identical(other.mPendingUrl, mPendingUrl) ||
                other.mPendingUrl == mPendingUrl) &&
            (identical(other.mNotifyUrl, mNotifyUrl) ||
                other.mNotifyUrl == mNotifyUrl) &&
            (identical(other.mBack2shopUrl, mBack2shopUrl) ||
                other.mBack2shopUrl == mBack2shopUrl) &&
            (identical(other.mEmailAddress, mEmailAddress) ||
                other.mEmailAddress == mEmailAddress) &&
            (identical(other.futureUse, futureUse) ||
                other.futureUse == futureUse) &&
            (identical(other.sendboxUrl, sendboxUrl) ||
                other.sendboxUrl == sendboxUrl) &&
            (identical(other.secret, secret) || other.secret == secret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        mUuid,
        mAccountUuid,
        mTxOrderNr,
        mTxId,
        mTxCurrency,
        mTxAmount,
        mTxItemName,
        mTxItemDescription,
        mMessage,
        mCategory1,
        mCategory2,
        mCategory3,
        mSiteName,
        mSiteReference,
        mCardAllowed,
        mEftAllowed,
        mPassAllowed,
        mChipsAllowed,
        mTridentAllowed,
        mPayatAllowed,
        bName,
        bSurname,
        bEmail,
        bMobile,
        mTxInvoiceNr,
        mTxDocumentRef,
        mTxDueDate,
        mReturnUrl,
        mCancelUrl,
        mPendingUrl,
        mNotifyUrl,
        mBack2shopUrl,
        mEmailAddress,
        futureUse,
        sendboxUrl,
        secret
      ]);

  @override
  String toString() {
    return 'MerchantTransaction(mUuid: $mUuid, mAccountUuid: $mAccountUuid, mTxOrderNr: $mTxOrderNr, mTxId: $mTxId, mTxCurrency: $mTxCurrency, mTxAmount: $mTxAmount, mTxItemName: $mTxItemName, mTxItemDescription: $mTxItemDescription, mMessage: $mMessage, mCategory1: $mCategory1, mCategory2: $mCategory2, mCategory3: $mCategory3, mSiteName: $mSiteName, mSiteReference: $mSiteReference, mCardAllowed: $mCardAllowed, mEftAllowed: $mEftAllowed, mPassAllowed: $mPassAllowed, mChipsAllowed: $mChipsAllowed, mTridentAllowed: $mTridentAllowed, mPayatAllowed: $mPayatAllowed, bName: $bName, bSurname: $bSurname, bEmail: $bEmail, bMobile: $bMobile, mTxInvoiceNr: $mTxInvoiceNr, mTxDocumentRef: $mTxDocumentRef, mTxDueDate: $mTxDueDate, mReturnUrl: $mReturnUrl, mCancelUrl: $mCancelUrl, mPendingUrl: $mPendingUrl, mNotifyUrl: $mNotifyUrl, mBack2shopUrl: $mBack2shopUrl, mEmailAddress: $mEmailAddress, futureUse: $futureUse, sendboxUrl: $sendboxUrl, secret: $secret)';
  }
}

/// @nodoc
abstract mixin class _$MerchantTransactionCopyWith<$Res>
    implements $MerchantTransactionCopyWith<$Res> {
  factory _$MerchantTransactionCopyWith(_MerchantTransaction value,
          $Res Function(_MerchantTransaction) _then) =
      __$MerchantTransactionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'm_uuid') String mUuid,
      @JsonKey(name: 'm_account_uuid') String mAccountUuid,
      @JsonKey(name: 'm_tx_order_nr') String mTxOrderNr,
      @JsonKey(name: 'm_tx_id') String mTxId,
      @JsonKey(name: 'm_tx_currency') String mTxCurrency,
      @JsonKey(name: 'm_tx_amount') String mTxAmount,
      @JsonKey(name: 'm_tx_item_name') String mTxItemName,
      @JsonKey(name: 'm_tx_item_description') String mTxItemDescription,
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
      @JsonKey(name: 'sendbox_url') String sendboxUrl,
      String secret});
}

/// @nodoc
class __$MerchantTransactionCopyWithImpl<$Res>
    implements _$MerchantTransactionCopyWith<$Res> {
  __$MerchantTransactionCopyWithImpl(this._self, this._then);

  final _MerchantTransaction _self;
  final $Res Function(_MerchantTransaction) _then;

  /// Create a copy of MerchantTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mUuid = null,
    Object? mAccountUuid = null,
    Object? mTxOrderNr = null,
    Object? mTxId = null,
    Object? mTxCurrency = null,
    Object? mTxAmount = null,
    Object? mTxItemName = null,
    Object? mTxItemDescription = null,
    Object? mMessage = freezed,
    Object? mCategory1 = freezed,
    Object? mCategory2 = freezed,
    Object? mCategory3 = freezed,
    Object? mSiteName = freezed,
    Object? mSiteReference = freezed,
    Object? mCardAllowed = freezed,
    Object? mEftAllowed = freezed,
    Object? mPassAllowed = freezed,
    Object? mChipsAllowed = freezed,
    Object? mTridentAllowed = freezed,
    Object? mPayatAllowed = freezed,
    Object? bName = freezed,
    Object? bSurname = freezed,
    Object? bEmail = freezed,
    Object? bMobile = freezed,
    Object? mTxInvoiceNr = freezed,
    Object? mTxDocumentRef = freezed,
    Object? mTxDueDate = freezed,
    Object? mReturnUrl = freezed,
    Object? mCancelUrl = freezed,
    Object? mPendingUrl = freezed,
    Object? mNotifyUrl = freezed,
    Object? mBack2shopUrl = freezed,
    Object? mEmailAddress = freezed,
    Object? futureUse = freezed,
    Object? sendboxUrl = null,
    Object? secret = null,
  }) {
    return _then(_MerchantTransaction(
      mUuid: null == mUuid
          ? _self.mUuid
          : mUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mAccountUuid: null == mAccountUuid
          ? _self.mAccountUuid
          : mAccountUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mTxOrderNr: null == mTxOrderNr
          ? _self.mTxOrderNr
          : mTxOrderNr // ignore: cast_nullable_to_non_nullable
              as String,
      mTxId: null == mTxId
          ? _self.mTxId
          : mTxId // ignore: cast_nullable_to_non_nullable
              as String,
      mTxCurrency: null == mTxCurrency
          ? _self.mTxCurrency
          : mTxCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      mTxAmount: null == mTxAmount
          ? _self.mTxAmount
          : mTxAmount // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemName: null == mTxItemName
          ? _self.mTxItemName
          : mTxItemName // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemDescription: null == mTxItemDescription
          ? _self.mTxItemDescription
          : mTxItemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      mMessage: freezed == mMessage
          ? _self.mMessage
          : mMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory1: freezed == mCategory1
          ? _self.mCategory1
          : mCategory1 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory2: freezed == mCategory2
          ? _self.mCategory2
          : mCategory2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory3: freezed == mCategory3
          ? _self.mCategory3
          : mCategory3 // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteName: freezed == mSiteName
          ? _self.mSiteName
          : mSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteReference: freezed == mSiteReference
          ? _self.mSiteReference
          : mSiteReference // ignore: cast_nullable_to_non_nullable
              as String?,
      mCardAllowed: freezed == mCardAllowed
          ? _self.mCardAllowed
          : mCardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mEftAllowed: freezed == mEftAllowed
          ? _self.mEftAllowed
          : mEftAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPassAllowed: freezed == mPassAllowed
          ? _self.mPassAllowed
          : mPassAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mChipsAllowed: freezed == mChipsAllowed
          ? _self.mChipsAllowed
          : mChipsAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mTridentAllowed: freezed == mTridentAllowed
          ? _self.mTridentAllowed
          : mTridentAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPayatAllowed: freezed == mPayatAllowed
          ? _self.mPayatAllowed
          : mPayatAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      bName: freezed == bName
          ? _self.bName
          : bName // ignore: cast_nullable_to_non_nullable
              as String?,
      bSurname: freezed == bSurname
          ? _self.bSurname
          : bSurname // ignore: cast_nullable_to_non_nullable
              as String?,
      bEmail: freezed == bEmail
          ? _self.bEmail
          : bEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bMobile: freezed == bMobile
          ? _self.bMobile
          : bMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxInvoiceNr: freezed == mTxInvoiceNr
          ? _self.mTxInvoiceNr
          : mTxInvoiceNr // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDocumentRef: freezed == mTxDocumentRef
          ? _self.mTxDocumentRef
          : mTxDocumentRef // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDueDate: freezed == mTxDueDate
          ? _self.mTxDueDate
          : mTxDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      mReturnUrl: freezed == mReturnUrl
          ? _self.mReturnUrl
          : mReturnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mCancelUrl: freezed == mCancelUrl
          ? _self.mCancelUrl
          : mCancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mPendingUrl: freezed == mPendingUrl
          ? _self.mPendingUrl
          : mPendingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mNotifyUrl: freezed == mNotifyUrl
          ? _self.mNotifyUrl
          : mNotifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mBack2shopUrl: freezed == mBack2shopUrl
          ? _self.mBack2shopUrl
          : mBack2shopUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mEmailAddress: freezed == mEmailAddress
          ? _self.mEmailAddress
          : mEmailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      futureUse: freezed == futureUse
          ? _self.futureUse
          : futureUse // ignore: cast_nullable_to_non_nullable
              as String?,
      sendboxUrl: null == sendboxUrl
          ? _self.sendboxUrl
          : sendboxUrl // ignore: cast_nullable_to_non_nullable
              as String,
      secret: null == secret
          ? _self.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
