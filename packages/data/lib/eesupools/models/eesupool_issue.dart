// ignore_for_file: invalid_annotation_target
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'eesupool_issue.freezed.dart';
part 'eesupool_issue.g.dart';

@freezed
abstract class EESUpoolIssue with _$EESUpoolIssue {
  const factory EESUpoolIssue({
    @JsonKey(includeToJson: false, name: 'issue_id') required String id,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'parent_pool_id') int? parentPoolId,
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    @JsonKey(name: 'reporter_id') String? reporterId,
    @JsonKey(name: 'offender_id') String? offenderId,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
    @JsonKey(name: 'message_id') int? chatMessageId,
    @JsonKey(name: 'attachments')
    @MediaFileConverter()
    List<MediaFile>? attachments,
    @ChatMessageConverter()
    @JsonKey(name: 'message', includeToJson: false)
    ChatMessage? chatMessage,
    @EESUpoolMemberConverter()
    @JsonKey(name: 'reporter_member', includeToJson: false)
    EESUpoolMember? reporter,
    @EESUpoolMemberConverter()
    @JsonKey(name: 'offender_member', includeToJson: false)
    EESUpoolMember? offender,
  }) = _EESUpoolIssue;

  factory EESUpoolIssue.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolIssueFromJson(json);
}
