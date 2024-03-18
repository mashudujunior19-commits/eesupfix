// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ozow_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OzowTransaction _$OzowTransactionFromJson(Map<String, dynamic> json) {
  return _OzowTransaction.fromJson(json);
}

/// @nodoc
mixin _$OzowTransaction {
  String? get transactionId => throw _privateConstructorUsedError;
  String? get merchantCode => throw _privateConstructorUsedError;
  String? get siteCode => throw _privateConstructorUsedError;
  String? get transactionReference => throw _privateConstructorUsedError;
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get statusMessage => throw _privateConstructorUsedError;
  String? get subStatus => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;
  DateTime? get paymentDate => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get maskedAccountNumber => throw _privateConstructorUsedError;
  String? get smartIndicators => throw _privateConstructorUsedError;
  String? get toBankName => throw _privateConstructorUsedError;
  String? get toAccountNumber => throw _privateConstructorUsedError;
  @OzowStatusConverter()
  OzowStatus? get status => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OzowTransactionCopyWith<OzowTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OzowTransactionCopyWith<$Res> {
  factory $OzowTransactionCopyWith(
          OzowTransaction value, $Res Function(OzowTransaction) then) =
      _$OzowTransactionCopyWithImpl<$Res, OzowTransaction>;
  @useResult
  $Res call(
      {String? transactionId,
      String? merchantCode,
      String? siteCode,
      String? transactionReference,
      String? currencyCode,
      String? statusMessage,
      String? subStatus,
      DateTime? createdDate,
      DateTime? paymentDate,
      String? bankName,
      String? maskedAccountNumber,
      String? smartIndicators,
      String? toBankName,
      String? toAccountNumber,
      @OzowStatusConverter() OzowStatus? status,
      double? amount});
}

/// @nodoc
class _$OzowTransactionCopyWithImpl<$Res, $Val extends OzowTransaction>
    implements $OzowTransactionCopyWith<$Res> {
  _$OzowTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = freezed,
    Object? merchantCode = freezed,
    Object? siteCode = freezed,
    Object? transactionReference = freezed,
    Object? currencyCode = freezed,
    Object? statusMessage = freezed,
    Object? subStatus = freezed,
    Object? createdDate = freezed,
    Object? paymentDate = freezed,
    Object? bankName = freezed,
    Object? maskedAccountNumber = freezed,
    Object? smartIndicators = freezed,
    Object? toBankName = freezed,
    Object? toAccountNumber = freezed,
    Object? status = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      merchantCode: freezed == merchantCode
          ? _value.merchantCode
          : merchantCode // ignore: cast_nullable_to_non_nullable
              as String?,
      siteCode: freezed == siteCode
          ? _value.siteCode
          : siteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionReference: freezed == transactionReference
          ? _value.transactionReference
          : transactionReference // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      statusMessage: freezed == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      subStatus: freezed == subStatus
          ? _value.subStatus
          : subStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      maskedAccountNumber: freezed == maskedAccountNumber
          ? _value.maskedAccountNumber
          : maskedAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      smartIndicators: freezed == smartIndicators
          ? _value.smartIndicators
          : smartIndicators // ignore: cast_nullable_to_non_nullable
              as String?,
      toBankName: freezed == toBankName
          ? _value.toBankName
          : toBankName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAccountNumber: freezed == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OzowStatus?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OzowTransactionImplCopyWith<$Res>
    implements $OzowTransactionCopyWith<$Res> {
  factory _$$OzowTransactionImplCopyWith(_$OzowTransactionImpl value,
          $Res Function(_$OzowTransactionImpl) then) =
      __$$OzowTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? transactionId,
      String? merchantCode,
      String? siteCode,
      String? transactionReference,
      String? currencyCode,
      String? statusMessage,
      String? subStatus,
      DateTime? createdDate,
      DateTime? paymentDate,
      String? bankName,
      String? maskedAccountNumber,
      String? smartIndicators,
      String? toBankName,
      String? toAccountNumber,
      @OzowStatusConverter() OzowStatus? status,
      double? amount});
}

/// @nodoc
class __$$OzowTransactionImplCopyWithImpl<$Res>
    extends _$OzowTransactionCopyWithImpl<$Res, _$OzowTransactionImpl>
    implements _$$OzowTransactionImplCopyWith<$Res> {
  __$$OzowTransactionImplCopyWithImpl(
      _$OzowTransactionImpl _value, $Res Function(_$OzowTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = freezed,
    Object? merchantCode = freezed,
    Object? siteCode = freezed,
    Object? transactionReference = freezed,
    Object? currencyCode = freezed,
    Object? statusMessage = freezed,
    Object? subStatus = freezed,
    Object? createdDate = freezed,
    Object? paymentDate = freezed,
    Object? bankName = freezed,
    Object? maskedAccountNumber = freezed,
    Object? smartIndicators = freezed,
    Object? toBankName = freezed,
    Object? toAccountNumber = freezed,
    Object? status = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$OzowTransactionImpl(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      merchantCode: freezed == merchantCode
          ? _value.merchantCode
          : merchantCode // ignore: cast_nullable_to_non_nullable
              as String?,
      siteCode: freezed == siteCode
          ? _value.siteCode
          : siteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionReference: freezed == transactionReference
          ? _value.transactionReference
          : transactionReference // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      statusMessage: freezed == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      subStatus: freezed == subStatus
          ? _value.subStatus
          : subStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      maskedAccountNumber: freezed == maskedAccountNumber
          ? _value.maskedAccountNumber
          : maskedAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      smartIndicators: freezed == smartIndicators
          ? _value.smartIndicators
          : smartIndicators // ignore: cast_nullable_to_non_nullable
              as String?,
      toBankName: freezed == toBankName
          ? _value.toBankName
          : toBankName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAccountNumber: freezed == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OzowStatus?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OzowTransactionImpl implements _OzowTransaction {
  const _$OzowTransactionImpl(
      {this.transactionId,
      this.merchantCode,
      this.siteCode,
      this.transactionReference,
      this.currencyCode,
      this.statusMessage,
      this.subStatus,
      this.createdDate,
      this.paymentDate,
      this.bankName,
      this.maskedAccountNumber,
      this.smartIndicators,
      this.toBankName,
      this.toAccountNumber,
      @OzowStatusConverter() this.status,
      this.amount});

  factory _$OzowTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$OzowTransactionImplFromJson(json);

  @override
  final String? transactionId;
  @override
  final String? merchantCode;
  @override
  final String? siteCode;
  @override
  final String? transactionReference;
  @override
  final String? currencyCode;
  @override
  final String? statusMessage;
  @override
  final String? subStatus;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? paymentDate;
  @override
  final String? bankName;
  @override
  final String? maskedAccountNumber;
  @override
  final String? smartIndicators;
  @override
  final String? toBankName;
  @override
  final String? toAccountNumber;
  @override
  @OzowStatusConverter()
  final OzowStatus? status;
  @override
  final double? amount;

  @override
  String toString() {
    return 'OzowTransaction(transactionId: $transactionId, merchantCode: $merchantCode, siteCode: $siteCode, transactionReference: $transactionReference, currencyCode: $currencyCode, statusMessage: $statusMessage, subStatus: $subStatus, createdDate: $createdDate, paymentDate: $paymentDate, bankName: $bankName, maskedAccountNumber: $maskedAccountNumber, smartIndicators: $smartIndicators, toBankName: $toBankName, toAccountNumber: $toAccountNumber, status: $status, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OzowTransactionImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.merchantCode, merchantCode) ||
                other.merchantCode == merchantCode) &&
            (identical(other.siteCode, siteCode) ||
                other.siteCode == siteCode) &&
            (identical(other.transactionReference, transactionReference) ||
                other.transactionReference == transactionReference) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage) &&
            (identical(other.subStatus, subStatus) ||
                other.subStatus == subStatus) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.maskedAccountNumber, maskedAccountNumber) ||
                other.maskedAccountNumber == maskedAccountNumber) &&
            (identical(other.smartIndicators, smartIndicators) ||
                other.smartIndicators == smartIndicators) &&
            (identical(other.toBankName, toBankName) ||
                other.toBankName == toBankName) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionId,
      merchantCode,
      siteCode,
      transactionReference,
      currencyCode,
      statusMessage,
      subStatus,
      createdDate,
      paymentDate,
      bankName,
      maskedAccountNumber,
      smartIndicators,
      toBankName,
      toAccountNumber,
      status,
      amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OzowTransactionImplCopyWith<_$OzowTransactionImpl> get copyWith =>
      __$$OzowTransactionImplCopyWithImpl<_$OzowTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OzowTransactionImplToJson(
      this,
    );
  }
}

abstract class _OzowTransaction implements OzowTransaction {
  const factory _OzowTransaction(
      {final String? transactionId,
      final String? merchantCode,
      final String? siteCode,
      final String? transactionReference,
      final String? currencyCode,
      final String? statusMessage,
      final String? subStatus,
      final DateTime? createdDate,
      final DateTime? paymentDate,
      final String? bankName,
      final String? maskedAccountNumber,
      final String? smartIndicators,
      final String? toBankName,
      final String? toAccountNumber,
      @OzowStatusConverter() final OzowStatus? status,
      final double? amount}) = _$OzowTransactionImpl;

  factory _OzowTransaction.fromJson(Map<String, dynamic> json) =
      _$OzowTransactionImpl.fromJson;

  @override
  String? get transactionId;
  @override
  String? get merchantCode;
  @override
  String? get siteCode;
  @override
  String? get transactionReference;
  @override
  String? get currencyCode;
  @override
  String? get statusMessage;
  @override
  String? get subStatus;
  @override
  DateTime? get createdDate;
  @override
  DateTime? get paymentDate;
  @override
  String? get bankName;
  @override
  String? get maskedAccountNumber;
  @override
  String? get smartIndicators;
  @override
  String? get toBankName;
  @override
  String? get toAccountNumber;
  @override
  @OzowStatusConverter()
  OzowStatus? get status;
  @override
  double? get amount;
  @override
  @JsonKey(ignore: true)
  _$$OzowTransactionImplCopyWith<_$OzowTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
