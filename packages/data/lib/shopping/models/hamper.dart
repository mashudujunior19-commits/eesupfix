// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamper.freezed.dart';
part 'hamper.g.dart';

@freezed
class Hamper with _$Hamper {
  factory Hamper({
    required String id,
    @JsonKey(name: 'code') required String hamperCode,
    @JsonKey(name: 'name') required String hamperName,
    required String type,
    required double value,
    @JsonKey(name: 'expiry_date') required DateTime expiryDate,
    @JsonKey(name: 'is_final') required bool isFinal,
    List<int>? productIds,
    @JsonKey(name: 'img_url') String? imgUrl,
    bool? isFree,
    Map<int, int>? quantity,
  }) = _Hamper;

  factory Hamper.fromJson(Map<String, dynamic> json) => _$HamperFromJson(json);
}
