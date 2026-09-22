import 'package:data/get_involved/models/document_type.dart';

typedef DocumentSpec = ({String label, String hint, List<String> extensions});

/// South African verification context per document type, shared by both the
/// registered and unregistered org forms.
const docSpecs = <DocumentType, DocumentSpec>{
  DocumentType.businessRegistration: (
    label: 'Business Registration Documents',
    hint: 'NPO registration certificate (DSD) or CIPC registration (NPC). '
        'PDF, JPG or PNG.',
    extensions: ['pdf', 'jpg', 'jpeg', 'png'],
  ),
  DocumentType.proofOfBank: (
    label: 'Proof of Bank',
    hint:
        'Bank confirmation letter or stamped statement, not older than 3 months.',
    extensions: ['pdf', 'jpg', 'jpeg', 'png'],
  ),
  DocumentType.proofOfResidence: (
    label: 'Proof of Residence',
    hint: 'Municipal bill, bank statement, utility account or lease -- not '
        'older than 3 months. PDF, JPG or PNG.',
    extensions: ['pdf', 'jpg', 'jpeg', 'png'],
  ),
  DocumentType.pboCertificate: (
    label: 'PBO Certificate',
    hint: 'SARS Section 30 approval, if the organisation is PBO-registered. PDF.',
    extensions: ['pdf'],
  ),
  DocumentType.constitution: (
    label: 'Constitution',
    hint: 'Founding document meeting Section 12 of the NPO Act. PDF.',
    extensions: ['pdf'],
  ),
  DocumentType.cipcDocument: (
    label: 'CIPC Document',
    hint: 'CIPC registration certificate (CoR14.3) or Notice of Incorporation '
        '(CoR14.1). PDF.',
    extensions: ['pdf'],
  ),
  DocumentType.vatDocument: (
    label: 'VAT Documents',
    hint: 'SARS VAT registration certificate, if applicable. PDF.',
    extensions: ['pdf'],
  ),
};
