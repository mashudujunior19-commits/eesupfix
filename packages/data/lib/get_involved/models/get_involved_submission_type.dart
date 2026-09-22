enum GetInvolvedSubmissionType {
  registeredNpo,
  unregisteredNpo,
  registeredBusiness,
  unregisteredBusiness;

  bool get isNPO =>
      this == GetInvolvedSubmissionType.registeredNpo ||
      this == GetInvolvedSubmissionType.unregisteredNpo;

  bool get isRegistered =>
      this == GetInvolvedSubmissionType.registeredNpo ||
      this == GetInvolvedSubmissionType.registeredBusiness;

  @override
  String toString() {
    switch (this) {
      case GetInvolvedSubmissionType.registeredNpo:
        return 'registered_npo';
      case GetInvolvedSubmissionType.unregisteredNpo:
        return 'unregistered_npo';
      case GetInvolvedSubmissionType.registeredBusiness:
        return 'registered_business';
      case GetInvolvedSubmissionType.unregisteredBusiness:
        return 'unregistered_business';
    }
  }

  factory GetInvolvedSubmissionType.fromString(String value) {
    switch (value) {
      case 'registered_npo':
        return GetInvolvedSubmissionType.registeredNpo;
      case 'unregistered_npo':
        return GetInvolvedSubmissionType.unregisteredNpo;
      case 'registered_business':
        return GetInvolvedSubmissionType.registeredBusiness;
      case 'unregistered_business':
        return GetInvolvedSubmissionType.unregisteredBusiness;
      default:
        throw Exception('Unknown get involved submission type: $value');
    }
  }

  factory GetInvolvedSubmissionType.from({
    required bool isNPO,
    required bool isRegistered,
  }) {
    if (isNPO) {
      return isRegistered
          ? GetInvolvedSubmissionType.registeredNpo
          : GetInvolvedSubmissionType.unregisteredNpo;
    }
    return isRegistered
        ? GetInvolvedSubmissionType.registeredBusiness
        : GetInvolvedSubmissionType.unregisteredBusiness;
  }
}
