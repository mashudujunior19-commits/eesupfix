// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

enum OzowStatus {
  Complete,
  Cancelled,
  Abandoned,
  PendingInvestigation,
  Pending,
  Error;

  factory OzowStatus.from(String status) {
    switch (status) {
      case 'Complete':
        return OzowStatus.Complete;
      case 'Cancelled':
        return OzowStatus.Cancelled;
      case 'Abandoned':
        return OzowStatus.Abandoned;
      case 'PendingInvestigation':
        return OzowStatus.PendingInvestigation;
      case 'Pending':
        return OzowStatus.Pending;
      default:
        return OzowStatus.Error;
    }
  }
}

class OzowStatusConverter implements JsonConverter<OzowStatus, String> {
  const OzowStatusConverter();

  @override
  OzowStatus fromJson(String status) => OzowStatus.from(status);

  @override
  String toJson(OzowStatus status) => status.name;
}
