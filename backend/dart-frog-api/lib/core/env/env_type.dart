enum EnvType {
  development,
  production;

  factory EnvType.fromString(String value) {
    switch (value) {
      case 'development':
        return EnvType.development;
      case 'production':
        return EnvType.production;
      default:
        return EnvType.development;
    }
  }

  @override
  String toString() {
    switch (this) {
      case EnvType.development:
        return 'Development';
      case EnvType.production:
        return 'Production';
      // ignore: no_default_cases
      default:
        return 'Unknown';
    }
  }
}
