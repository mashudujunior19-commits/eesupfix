import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_file.freezed.dart';
part 'media_file.g.dart';

class MediaFileConverter
    implements JsonConverter<MediaFile, Map<String, dynamic>> {
  const MediaFileConverter();

  @override
  MediaFile fromJson(Map<String, dynamic> json) {
    return MediaFile.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MediaFile object) {
    return object.toJson();
  }
}

@freezed
abstract class MediaFile with _$MediaFile {
  const factory MediaFile({
    required String name,
    required String url,
    required String type,
  }) = _MediaFile;

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);
}
