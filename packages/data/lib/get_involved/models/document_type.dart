enum DocumentType {
  businessRegistration,
  proofOfBank,
  proofOfResidence,
  pboCertificate,
  constitution,
  cipcDocument,
  vatDocument;

  @override
  String toString() {
    switch (this) {
      case DocumentType.businessRegistration:
        return 'business_registration';
      case DocumentType.proofOfBank:
        return 'proof_of_bank';
      case DocumentType.proofOfResidence:
        return 'proof_of_residence';
      case DocumentType.pboCertificate:
        return 'pbo_certificate';
      case DocumentType.constitution:
        return 'constitution';
      case DocumentType.cipcDocument:
        return 'cipc_document';
      case DocumentType.vatDocument:
        return 'vat_document';
    }
  }

  factory DocumentType.fromString(String value) {
    switch (value) {
      case 'business_registration':
        return DocumentType.businessRegistration;
      case 'proof_of_bank':
        return DocumentType.proofOfBank;
      case 'proof_of_residence':
        return DocumentType.proofOfResidence;
      case 'pbo_certificate':
        return DocumentType.pboCertificate;
      case 'constitution':
        return DocumentType.constitution;
      case 'cipc_document':
        return DocumentType.cipcDocument;
      case 'vat_document':
        return DocumentType.vatDocument;
      default:
        throw Exception('Unknown document type: $value');
    }
  }
}
