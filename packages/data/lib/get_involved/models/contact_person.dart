import 'package:data/get_involved/models/contact_person_role.dart';

class ContactPerson {
  final String? id;
  final String? submissionId;
  final String? name;
  final String email;
  final String phone;
  final ContactPersonRole? role;

  const ContactPerson({
    this.id,
    this.submissionId,
    this.name,
    required this.email,
    required this.phone,
    this.role,
  });

  /// Sentinel used to distinguish "leave this field alone" from "clear this
  /// field to null" -- a plain `value ?? this.value` copyWith can never set
  /// a nullable field back to null once it has a value.
  static const _unset = Object();

  ContactPerson copyWith({
    Object? name = _unset,
    String? email,
    String? phone,
    Object? role = _unset,
  }) {
    return ContactPerson(
      id: id,
      submissionId: submissionId,
      name: identical(name, _unset) ? this.name : name as String?,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: identical(role, _unset) ? this.role : role as ContactPersonRole?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (submissionId != null) 'submission_id': submissionId,
      if (name != null) 'name': name,
      'email': email,
      'phone': phone,
      if (role != null) 'role': role.toString(),
    };
  }

  factory ContactPerson.fromJson(Map<String, dynamic> json) {
    return ContactPerson(
      id: json['id'] as String?,
      submissionId: json['submission_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] == null
          ? null
          : ContactPersonRole.fromString(json['role'] as String),
    );
  }
}
