enum GetInvolvedApplicationType {
  registered,
  unregistered;

  @override
  String toString() {
    switch (this) {
      case GetInvolvedApplicationType.registered:
        return 'registered';
      case GetInvolvedApplicationType.unregistered:
        return 'unregistered';
    }
  }

  factory GetInvolvedApplicationType.fromString(String value) {
    switch (value) {
      case 'registered':
        return GetInvolvedApplicationType.registered;
      case 'unregistered':
        return GetInvolvedApplicationType.unregistered;
      default:
        throw Exception('Unknown get involved application type: $value');
    }
  }
}
