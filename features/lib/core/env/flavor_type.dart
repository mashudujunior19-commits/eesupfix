enum FlavorType {
  test,
  development,
  production;

  factory FlavorType.fromString(String env) {
    switch (env) {
      case 'test':
        return FlavorType.test;
      case 'development':
        return FlavorType.development;
      case 'production':
        return FlavorType.production;
      default:
        throw Exception('Invalid environment type');
    }
  }
}
