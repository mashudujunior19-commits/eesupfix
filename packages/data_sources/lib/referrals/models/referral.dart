// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

@freezed
class Referral with _$Referral {
  const factory Referral({
    @JsonKey(name: 'referrer_user_id') required String referrerUserId,
    @JsonKey(name: 'refereed_user_id') required String refereedUserId,
    @JsonKey(name: 'refereed_full_name') required String refereedFullName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'transaction_id') required int transactionId,
    @JsonKey(name: 'is_completed') required bool isCompleted,
  }) = _Referral;

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
}
