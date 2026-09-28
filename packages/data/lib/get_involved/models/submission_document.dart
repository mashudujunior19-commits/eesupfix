import 'package:data/get_involved/models/document_type.dart';

class SubmissionDocument {
  final String? id;
  final String submissionId;
  final DocumentType documentType;
  final String filePath;
  final DateTime? uploadedAt;

  const SubmissionDocument({
    this.id,
    required this.submissionId,
    required this.documentType,
    required this.filePath,
    this.uploadedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'submission_id': submissionId,
      'document_type': documentType.toString(),
      'file_path': filePath,
    };
  }

  factory SubmissionDocument.fromJson(Map<String, dynamic> json) {
    return SubmissionDocument(
      id: json['id'] as String?,
      submissionId: json['submission_id'] as String,
      documentType: DocumentType.fromString(json['document_type'] as String),
      filePath: json['file_path'] as String,
      uploadedAt: json['uploaded_at'] == null
          ? null
          : DateTime.parse(json['uploaded_at'] as String),
    );
  }
}
