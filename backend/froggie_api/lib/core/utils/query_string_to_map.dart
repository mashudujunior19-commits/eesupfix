Map<String, dynamic> queryStringToMap(String queryString) {
  final map = <String, String>{};

  // Split the string into key-value pairs
  final pairs = queryString.split('&');

  for (final pair in pairs) {
    // Split each pair at the first '='
    final idx = pair.indexOf('=');
    if (idx != -1) {
      var key = pair.substring(0, idx);
      var value = pair.substring(idx + 1);

      // URL decode the key and the value
      key = Uri.decodeComponent(key);
      value = Uri.decodeComponent(value);

      map[key] = value;
    }
  }

  return map;
}
