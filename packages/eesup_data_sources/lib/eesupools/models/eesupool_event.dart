// ignore_for_file: invalid_annotation_target

import 'package:eesup_data_source/eesupools/models/eesupool_member.dart';
import 'package:eesup_data_source/eesupools/models/media_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool_event.freezed.dart';
part 'eesupool_event.g.dart';

@freezed
class EESUpoolEvent with _$EESUpoolEvent {
  const factory EESUpoolEvent({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'address_id') int? addressId,
    @JsonKey(name: 'start_at') required DateTime startAt,
    @JsonKey(name: 'end_at') required DateTime endAt,
    @EESUpoolMemberConverter()
    @JsonKey(name: 'attendees', includeToJson: false)
    List<EESUpoolMember>? attendees,
    @JsonKey(name: 'remote_url') String? remoteUrl,
    @MediaFileConverter() List<MediaFile>? attachments,
  }) = _EESUpoolEvent;

  factory EESUpoolEvent.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolEventFromJson(json);
}
