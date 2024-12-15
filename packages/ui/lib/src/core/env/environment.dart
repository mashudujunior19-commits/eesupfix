enum Environment {
  test,
  development,
  production;

  factory Environment.fromString(String env) {
    switch (env) {
      case 'test':
        return Environment.test;
      case 'development':
        return Environment.development;
      case 'production':
        return Environment.production;
      default:
        throw Exception('Invalid environment type');
    }
  }
}
