import 'package:freezed_annotation/freezed_annotation.dart';

/// The role a bulk order receiver plays in fulfilling a KasiPool order,
/// assigned by the pool admin so it's clear who does what.
enum ReceiverRole {
  receiver,
  packer,
  distributor;

  String get label {
    switch (this) {
      case ReceiverRole.receiver:
        return 'Receiver';
      case ReceiverRole.packer:
        return 'Packer';
      case ReceiverRole.distributor:
        return 'Distributor';
    }
  }

  @override
  String toString() {
    switch (this) {
      case ReceiverRole.receiver:
        return 'receiver';
      case ReceiverRole.packer:
        return 'packer';
      case ReceiverRole.distributor:
        return 'distributor';
    }
  }

  factory ReceiverRole.fromString(String value) {
    switch (value) {
      case 'receiver':
        return ReceiverRole.receiver;
      case 'packer':
        return ReceiverRole.packer;
      case 'distributor':
        return ReceiverRole.distributor;
      default:
        throw Exception('Unknown receiver role: $value');
    }
  }
}

/// Converts the `receiver_roles` jsonb column (member id -> role) to/from a
/// typed map. Kept permissive on read (an unrecognised role or a malformed
/// entry is dropped rather than throwing) since this map is best-effort
/// display/assignment metadata, not something that should ever break
/// loading an order.
class ReceiverRolesConverter
    implements JsonConverter<Map<String, ReceiverRole>, Map<String, dynamic>?> {
  const ReceiverRolesConverter();

  @override
  Map<String, ReceiverRole> fromJson(Map<String, dynamic>? json) {
    if (json == null) return const {};
    final result = <String, ReceiverRole>{};
    for (final entry in json.entries) {
      final value = entry.value;
      if (value is! String) continue;
      try {
        result[entry.key] = ReceiverRole.fromString(value);
      } catch (_) {
        // Skip unrecognised roles rather than failing the whole fetch.
      }
    }
    return result;
  }

  @override
  Map<String, dynamic> toJson(Map<String, ReceiverRole> object) {
    return object.map((key, value) => MapEntry(key, value.toString()));
  }
}
