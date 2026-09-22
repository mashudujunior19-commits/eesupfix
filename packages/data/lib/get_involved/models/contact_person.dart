class ContactPerson {
  final String? id;
  final String? submissionId;
  final String email;
  final String phone;

  const ContactPerson({
    this.id,
    this.submissionId,
    required this.email,
    required this.phone,
  });

  ContactPerson copyWith({String? email, String? phone}) {
    return ContactPerson(
      id: id,
      submissionId: submissionId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (submissionId != null) 'submission_id': submissionId,
      'email': email,
      'phone': phone,
    };
  }

  factory ContactPerson.fromJson(Map<String, dynamic> json) {
    return ContactPerson(
      id: json['id'] as String?,
      submissionId: json['submission_id'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }
}
