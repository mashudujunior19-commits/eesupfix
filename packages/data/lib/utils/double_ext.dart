extension RoundingExtension on double {
  String toRounded() {
    final str = toStringAsFixed(3);
    final split = str.split('.');
    String newStr = '${split[0]}.${split[1].substring(0, 2)}';
    return newStr;
  }
}

