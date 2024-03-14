// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MerchantTransaction _$MerchantTransactionFromJson(Map<String, dynamic> json) {
  return _MerchantTransaction.fromJson(json);
}

/// @nodoc
mixin _$MerchantTransaction {
  @JsonKey(name: 'm_uuid')
  String get mUuid => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_account_uuid')
  String get mAccountUuid => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_order_nr')
  String get mTxOrderNr => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_id')
  String get mTxId => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_currency')
  String get mTxCurrency => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_amount')
  String get mTxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_item_name')
  String get mTxItemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_item_description')
  String get mTxItemDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_message')
  String? get mMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_category_1')
  String? get mCategory1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_category_2')
  String? get mCategory2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_category_3')
  String? get mCategory3 => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_site_name')
  String? get mSiteName => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_site_reference')
  String? get mSiteReference => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_card_allowed')
  bool? get mCardAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_ieft_allowed')
  bool? get mEftAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_pass_allowed')
  bool? get mPassAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_chips_allowed')
  bool? get mChipsAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_trident_allowed')
  bool? get mTridentAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_payat_allowed')
  bool? get mPayatAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'b_name')
  String? get bName => throw _privateConstructorUsedError;
  @JsonKey(name: 'b_surname')
  String? get bSurname => throw _privateConstructorUsedError;
  @JsonKey(name: 'b_email')
  String? get bEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'b_mobile')
  String? get bMobile => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_invoice_nr')
  String? get mTxInvoiceNr => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_document_ref')
  String? get mTxDocumentRef => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_tx_due_date')
  String? get mTxDueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_return_url')
  String? get mReturnUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_cancel_url')
  String? get mCancelUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_pending_url')
  String? get mPendingUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_notify_url')
  String? get mNotifyUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_back2shop_url')
  String? get mBack2shopUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'm_email_address')
  String? get mEmailAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'future_use')
  String? get futureUse => throw _privateConstructorUsedError;
  String get secret => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MerchantTransactionCopyWith<MerchantTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MerchantTransactionCopyWith<$Res> {
  factory $MerchantTransactionCopyWith(
          MerchantTransaction value, $Res Function(MerchantTransaction) then) =
      _$MerchantTransactionCopyWithImpl<$Res, MerchantTransaction>;
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
      String secret});
}

/// @nodoc
class _$MerchantTransactionCopyWithImpl<$Res, $Val extends MerchantTransaction>
    implements $MerchantTransactionCopyWith<$Res> {
  _$MerchantTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? secret = null,
  }) {
    return _then(_value.copyWith(
      mUuid: null == mUuid
          ? _value.mUuid
          : mUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mAccountUuid: null == mAccountUuid
          ? _value.mAccountUuid
          : mAccountUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mTxOrderNr: null == mTxOrderNr
          ? _value.mTxOrderNr
          : mTxOrderNr // ignore: cast_nullable_to_non_nullable
              as String,
      mTxId: null == mTxId
          ? _value.mTxId
          : mTxId // ignore: cast_nullable_to_non_nullable
              as String,
      mTxCurrency: null == mTxCurrency
          ? _value.mTxCurrency
          : mTxCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      mTxAmount: null == mTxAmount
          ? _value.mTxAmount
          : mTxAmount // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemName: null == mTxItemName
          ? _value.mTxItemName
          : mTxItemName // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemDescription: null == mTxItemDescription
          ? _value.mTxItemDescription
          : mTxItemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      mMessage: freezed == mMessage
          ? _value.mMessage
          : mMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory1: freezed == mCategory1
          ? _value.mCategory1
          : mCategory1 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory2: freezed == mCategory2
          ? _value.mCategory2
          : mCategory2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory3: freezed == mCategory3
          ? _value.mCategory3
          : mCategory3 // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteName: freezed == mSiteName
          ? _value.mSiteName
          : mSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteReference: freezed == mSiteReference
          ? _value.mSiteReference
          : mSiteReference // ignore: cast_nullable_to_non_nullable
              as String?,
      mCardAllowed: freezed == mCardAllowed
          ? _value.mCardAllowed
          : mCardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mEftAllowed: freezed == mEftAllowed
          ? _value.mEftAllowed
          : mEftAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPassAllowed: freezed == mPassAllowed
          ? _value.mPassAllowed
          : mPassAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mChipsAllowed: freezed == mChipsAllowed
          ? _value.mChipsAllowed
          : mChipsAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mTridentAllowed: freezed == mTridentAllowed
          ? _value.mTridentAllowed
          : mTridentAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPayatAllowed: freezed == mPayatAllowed
          ? _value.mPayatAllowed
          : mPayatAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      bName: freezed == bName
          ? _value.bName
          : bName // ignore: cast_nullable_to_non_nullable
              as String?,
      bSurname: freezed == bSurname
          ? _value.bSurname
          : bSurname // ignore: cast_nullable_to_non_nullable
              as String?,
      bEmail: freezed == bEmail
          ? _value.bEmail
          : bEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bMobile: freezed == bMobile
          ? _value.bMobile
          : bMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxInvoiceNr: freezed == mTxInvoiceNr
          ? _value.mTxInvoiceNr
          : mTxInvoiceNr // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDocumentRef: freezed == mTxDocumentRef
          ? _value.mTxDocumentRef
          : mTxDocumentRef // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDueDate: freezed == mTxDueDate
          ? _value.mTxDueDate
          : mTxDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      mReturnUrl: freezed == mReturnUrl
          ? _value.mReturnUrl
          : mReturnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mCancelUrl: freezed == mCancelUrl
          ? _value.mCancelUrl
          : mCancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mPendingUrl: freezed == mPendingUrl
          ? _value.mPendingUrl
          : mPendingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mNotifyUrl: freezed == mNotifyUrl
          ? _value.mNotifyUrl
          : mNotifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mBack2shopUrl: freezed == mBack2shopUrl
          ? _value.mBack2shopUrl
          : mBack2shopUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mEmailAddress: freezed == mEmailAddress
          ? _value.mEmailAddress
          : mEmailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      futureUse: freezed == futureUse
          ? _value.futureUse
          : futureUse // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MerchantTransactionImplCopyWith<$Res>
    implements $MerchantTransactionCopyWith<$Res> {
  factory _$$MerchantTransactionImplCopyWith(_$MerchantTransactionImpl value,
          $Res Function(_$MerchantTransactionImpl) then) =
      __$$MerchantTransactionImplCopyWithImpl<$Res>;
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
      String secret});
}

/// @nodoc
class __$$MerchantTransactionImplCopyWithImpl<$Res>
    extends _$MerchantTransactionCopyWithImpl<$Res, _$MerchantTransactionImpl>
    implements _$$MerchantTransactionImplCopyWith<$Res> {
  __$$MerchantTransactionImplCopyWithImpl(_$MerchantTransactionImpl _value,
      $Res Function(_$MerchantTransactionImpl) _then)
      : super(_value, _then);

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
    Object? secret = null,
  }) {
    return _then(_$MerchantTransactionImpl(
      mUuid: null == mUuid
          ? _value.mUuid
          : mUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mAccountUuid: null == mAccountUuid
          ? _value.mAccountUuid
          : mAccountUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mTxOrderNr: null == mTxOrderNr
          ? _value.mTxOrderNr
          : mTxOrderNr // ignore: cast_nullable_to_non_nullable
              as String,
      mTxId: null == mTxId
          ? _value.mTxId
          : mTxId // ignore: cast_nullable_to_non_nullable
              as String,
      mTxCurrency: null == mTxCurrency
          ? _value.mTxCurrency
          : mTxCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      mTxAmount: null == mTxAmount
          ? _value.mTxAmount
          : mTxAmount // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemName: null == mTxItemName
          ? _value.mTxItemName
          : mTxItemName // ignore: cast_nullable_to_non_nullable
              as String,
      mTxItemDescription: null == mTxItemDescription
          ? _value.mTxItemDescription
          : mTxItemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      mMessage: freezed == mMessage
          ? _value.mMessage
          : mMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory1: freezed == mCategory1
          ? _value.mCategory1
          : mCategory1 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory2: freezed == mCategory2
          ? _value.mCategory2
          : mCategory2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mCategory3: freezed == mCategory3
          ? _value.mCategory3
          : mCategory3 // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteName: freezed == mSiteName
          ? _value.mSiteName
          : mSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      mSiteReference: freezed == mSiteReference
          ? _value.mSiteReference
          : mSiteReference // ignore: cast_nullable_to_non_nullable
              as String?,
      mCardAllowed: freezed == mCardAllowed
          ? _value.mCardAllowed
          : mCardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mEftAllowed: freezed == mEftAllowed
          ? _value.mEftAllowed
          : mEftAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPassAllowed: freezed == mPassAllowed
          ? _value.mPassAllowed
          : mPassAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mChipsAllowed: freezed == mChipsAllowed
          ? _value.mChipsAllowed
          : mChipsAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mTridentAllowed: freezed == mTridentAllowed
          ? _value.mTridentAllowed
          : mTridentAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      mPayatAllowed: freezed == mPayatAllowed
          ? _value.mPayatAllowed
          : mPayatAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      bName: freezed == bName
          ? _value.bName
          : bName // ignore: cast_nullable_to_non_nullable
              as String?,
      bSurname: freezed == bSurname
          ? _value.bSurname
          : bSurname // ignore: cast_nullable_to_non_nullable
              as String?,
      bEmail: freezed == bEmail
          ? _value.bEmail
          : bEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bMobile: freezed == bMobile
          ? _value.bMobile
          : bMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxInvoiceNr: freezed == mTxInvoiceNr
          ? _value.mTxInvoiceNr
          : mTxInvoiceNr // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDocumentRef: freezed == mTxDocumentRef
          ? _value.mTxDocumentRef
          : mTxDocumentRef // ignore: cast_nullable_to_non_nullable
              as String?,
      mTxDueDate: freezed == mTxDueDate
          ? _value.mTxDueDate
          : mTxDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      mReturnUrl: freezed == mReturnUrl
          ? _value.mReturnUrl
          : mReturnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mCancelUrl: freezed == mCancelUrl
          ? _value.mCancelUrl
          : mCancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mPendingUrl: freezed == mPendingUrl
          ? _value.mPendingUrl
          : mPendingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mNotifyUrl: freezed == mNotifyUrl
          ? _value.mNotifyUrl
          : mNotifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mBack2shopUrl: freezed == mBack2shopUrl
          ? _value.mBack2shopUrl
          : mBack2shopUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mEmailAddress: freezed == mEmailAddress
          ? _value.mEmailAddress
          : mEmailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      futureUse: freezed == futureUse
          ? _value.futureUse
          : futureUse // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MerchantTransactionImpl implements _MerchantTransaction {
  _$MerchantTransactionImpl(
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
      required this.secret});

  factory _$MerchantTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MerchantTransactionImplFromJson(json);

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
  final String secret;

  @override
  String toString() {
    return 'MerchantTransaction(mUuid: $mUuid, mAccountUuid: $mAccountUuid, mTxOrderNr: $mTxOrderNr, mTxId: $mTxId, mTxCurrency: $mTxCurrency, mTxAmount: $mTxAmount, mTxItemName: $mTxItemName, mTxItemDescription: $mTxItemDescription, mMessage: $mMessage, mCategory1: $mCategory1, mCategory2: $mCategory2, mCategory3: $mCategory3, mSiteName: $mSiteName, mSiteReference: $mSiteReference, mCardAllowed: $mCardAllowed, mEftAllowed: $mEftAllowed, mPassAllowed: $mPassAllowed, mChipsAllowed: $mChipsAllowed, mTridentAllowed: $mTridentAllowed, mPayatAllowed: $mPayatAllowed, bName: $bName, bSurname: $bSurname, bEmail: $bEmail, bMobile: $bMobile, mTxInvoiceNr: $mTxInvoiceNr, mTxDocumentRef: $mTxDocumentRef, mTxDueDate: $mTxDueDate, mReturnUrl: $mReturnUrl, mCancelUrl: $mCancelUrl, mPendingUrl: $mPendingUrl, mNotifyUrl: $mNotifyUrl, mBack2shopUrl: $mBack2shopUrl, mEmailAddress: $mEmailAddress, futureUse: $futureUse, secret: $secret)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MerchantTransactionImpl &&
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
            (identical(other.secret, secret) || other.secret == secret));
  }

  @JsonKey(ignore: true)
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
        secret
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MerchantTransactionImplCopyWith<_$MerchantTransactionImpl> get copyWith =>
      __$$MerchantTransactionImplCopyWithImpl<_$MerchantTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MerchantTransactionImplToJson(
      this,
    );
  }
}

abstract class _MerchantTransaction implements MerchantTransaction {
  factory _MerchantTransaction(
      {@JsonKey(name: 'm_uuid') required final String mUuid,
      @JsonKey(name: 'm_account_uuid') required final String mAccountUuid,
      @JsonKey(name: 'm_tx_order_nr') required final String mTxOrderNr,
      @JsonKey(name: 'm_tx_id') required final String mTxId,
      @JsonKey(name: 'm_tx_currency') required final String mTxCurrency,
      @JsonKey(name: 'm_tx_amount') required final String mTxAmount,
      @JsonKey(name: 'm_tx_item_name') required final String mTxItemName,
      @JsonKey(name: 'm_tx_item_description')
      required final String mTxItemDescription,
      @JsonKey(name: 'm_message') final String? mMessage,
      @JsonKey(name: 'm_category_1') final String? mCategory1,
      @JsonKey(name: 'm_category_2') final String? mCategory2,
      @JsonKey(name: 'm_category_3') final String? mCategory3,
      @JsonKey(name: 'm_site_name') final String? mSiteName,
      @JsonKey(name: 'm_site_reference') final String? mSiteReference,
      @JsonKey(name: 'm_card_allowed') final bool? mCardAllowed,
      @JsonKey(name: 'm_ieft_allowed') final bool? mEftAllowed,
      @JsonKey(name: 'm_pass_allowed') final bool? mPassAllowed,
      @JsonKey(name: 'm_chips_allowed') final bool? mChipsAllowed,
      @JsonKey(name: 'm_trident_allowed') final bool? mTridentAllowed,
      @JsonKey(name: 'm_payat_allowed') final bool? mPayatAllowed,
      @JsonKey(name: 'b_name') final String? bName,
      @JsonKey(name: 'b_surname') final String? bSurname,
      @JsonKey(name: 'b_email') final String? bEmail,
      @JsonKey(name: 'b_mobile') final String? bMobile,
      @JsonKey(name: 'm_tx_invoice_nr') final String? mTxInvoiceNr,
      @JsonKey(name: 'm_tx_document_ref') final String? mTxDocumentRef,
      @JsonKey(name: 'm_tx_due_date') final String? mTxDueDate,
      @JsonKey(name: 'm_return_url') final String? mReturnUrl,
      @JsonKey(name: 'm_cancel_url') final String? mCancelUrl,
      @JsonKey(name: 'm_pending_url') final String? mPendingUrl,
      @JsonKey(name: 'm_notify_url') final String? mNotifyUrl,
      @JsonKey(name: 'm_back2shop_url') final String? mBack2shopUrl,
      @JsonKey(name: 'm_email_address') final String? mEmailAddress,
      @JsonKey(name: 'future_use') final String? futureUse,
      required final String secret}) = _$MerchantTransactionImpl;

  factory _MerchantTransaction.fromJson(Map<String, dynamic> json) =
      _$MerchantTransactionImpl.fromJson;

  @override
  @JsonKey(name: 'm_uuid')
  String get mUuid;
  @override
  @JsonKey(name: 'm_account_uuid')
  String get mAccountUuid;
  @override
  @JsonKey(name: 'm_tx_order_nr')
  String get mTxOrderNr;
  @override
  @JsonKey(name: 'm_tx_id')
  String get mTxId;
  @override
  @JsonKey(name: 'm_tx_currency')
  String get mTxCurrency;
  @override
  @JsonKey(name: 'm_tx_amount')
  String get mTxAmount;
  @override
  @JsonKey(name: 'm_tx_item_name')
  String get mTxItemName;
  @override
  @JsonKey(name: 'm_tx_item_description')
  String get mTxItemDescription;
  @override
  @JsonKey(name: 'm_message')
  String? get mMessage;
  @override
  @JsonKey(name: 'm_category_1')
  String? get mCategory1;
  @override
  @JsonKey(name: 'm_category_2')
  String? get mCategory2;
  @override
  @JsonKey(name: 'm_category_3')
  String? get mCategory3;
  @override
  @JsonKey(name: 'm_site_name')
  String? get mSiteName;
  @override
  @JsonKey(name: 'm_site_reference')
  String? get mSiteReference;
  @override
  @JsonKey(name: 'm_card_allowed')
  bool? get mCardAllowed;
  @override
  @JsonKey(name: 'm_ieft_allowed')
  bool? get mEftAllowed;
  @override
  @JsonKey(name: 'm_pass_allowed')
  bool? get mPassAllowed;
  @override
  @JsonKey(name: 'm_chips_allowed')
  bool? get mChipsAllowed;
  @override
  @JsonKey(name: 'm_trident_allowed')
  bool? get mTridentAllowed;
  @override
  @JsonKey(name: 'm_payat_allowed')
  bool? get mPayatAllowed;
  @override
  @JsonKey(name: 'b_name')
  String? get bName;
  @override
  @JsonKey(name: 'b_surname')
  String? get bSurname;
  @override
  @JsonKey(name: 'b_email')
  String? get bEmail;
  @override
  @JsonKey(name: 'b_mobile')
  String? get bMobile;
  @override
  @JsonKey(name: 'm_tx_invoice_nr')
  String? get mTxInvoiceNr;
  @override
  @JsonKey(name: 'm_tx_document_ref')
  String? get mTxDocumentRef;
  @override
  @JsonKey(name: 'm_tx_due_date')
  String? get mTxDueDate;
  @override
  @JsonKey(name: 'm_return_url')
  String? get mReturnUrl;
  @override
  @JsonKey(name: 'm_cancel_url')
  String? get mCancelUrl;
  @override
  @JsonKey(name: 'm_pending_url')
  String? get mPendingUrl;
  @override
  @JsonKey(name: 'm_notify_url')
  String? get mNotifyUrl;
  @override
  @JsonKey(name: 'm_back2shop_url')
  String? get mBack2shopUrl;
  @override
  @JsonKey(name: 'm_email_address')
  String? get mEmailAddress;
  @override
  @JsonKey(name: 'future_use')
  String? get futureUse;
  @override
  String get secret;
  @override
  @JsonKey(ignore: true)
  _$$MerchantTransactionImplCopyWith<_$MerchantTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
