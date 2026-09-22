import 'dart:typed_data';

/// An in-memory representation of a document the user picked, used instead
/// of a `dart:io` `File` so the same code path works on both web (where
/// files only ever exist as bytes, never a real filesystem path) and
/// mobile/desktop.
class PickedDocument {
  final String fileName;
  final Uint8List bytes;

  const PickedDocument({required this.fileName, required this.bytes});

  String get extension =>
      fileName.contains('.') ? fileName.split('.').last : '';
}
