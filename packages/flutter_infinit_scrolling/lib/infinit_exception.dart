class KeyIsNullException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  KeyIsNullException(this.message, this.stackTrace);
}



class DuplicateKeyException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  DuplicateKeyException(this.message, this.stackTrace);
}