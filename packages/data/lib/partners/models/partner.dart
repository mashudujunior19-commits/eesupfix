// ignore_for_file: invalid_annotation_target

import 'package:data/partners/models/partner_survey.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner.freezed.dart';
part 'partner.g.dart';

@freezed
abstract class Partner with _$Partner {
  const factory Partner({
    required String id,
    required String title,
    required String description,
    @PartnerSurveyConverter() required List<PartnerSurvey> surveys,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'is_open') required bool isOpen,
    @JsonKey(name: 'max_apps') required int maxApps,
  }) = _Partner;

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}
