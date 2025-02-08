import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_control.freezed.dart';
part 'version_control.g.dart';

@freezed
class VersionControl with _$VersionControl {
  const factory VersionControl({
    required int id,
    required DateTime createdAt,
    String? versionNumber,
    int? buildNumber,
    bool? isLive,
    String? appStoreUrl,
    String? iosUrl,
    String? huaweiUrl,
  }) = _VersionControl;

  factory VersionControl.fromJson(Map<String, dynamic> json) =>
      _$VersionControlFromJson(json);
}
