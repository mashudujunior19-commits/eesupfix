enum EnvironmentType {
  test,
  development,
  production;

  factory EnvironmentType.fromString(String env) {
    switch (env) {
      case 'test':
        return EnvironmentType.test;
      case 'development':
        return EnvironmentType.development;
      case 'production':
        return EnvironmentType.production;
      default:
        throw Exception('Invalid environment type');
    }
  }
}
