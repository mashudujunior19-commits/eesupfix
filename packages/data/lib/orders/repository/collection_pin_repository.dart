import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The customer's view of their KasiPool order's collection PIN.
class CollectionPin {
  const CollectionPin({
    required this.state,
    this.pin,
    this.message,
    this.issuedAt,
  });

  /// not_pool_order | waiting | ready | collected | cancelled
  final String state;

  /// Only present when [state] is ready, and only for the customer.
  final String? pin;
  final String? message;
  final DateTime? issuedAt;

  bool get isReady => state == 'ready' && pin != null;

  factory CollectionPin.fromJson(Map<String, dynamic> json) => CollectionPin(
        state: (json['state'] ?? 'waiting') as String,
        pin: json['pin'] as String?,
        message: json['message'] as String?,
        issuedAt: json['issued_at'] == null
            ? null
            : DateTime.tryParse(json['issued_at'].toString())?.toLocal(),
      );
}

/// What the Dispatcher gets back after entering a PIN.
class CollectionPinResult {
  const CollectionPinResult({
    required this.ok,
    required this.message,
    this.reason,
    this.attemptsLeft,
    this.locked = false,
  });

  final bool ok;
  final String message;

  /// wrong | locked | not_issued | cancelled (when not ok)
  final String? reason;
  final int? attemptsLeft;
  final bool locked;

  factory CollectionPinResult.fromJson(Map<String, dynamic> json) =>
      CollectionPinResult(
        ok: json['ok'] == true,
        message: (json['message'] ?? '') as String,
        reason: json['reason'] as String?,
        attemptsLeft: (json['attempts_left'] as num?)?.toInt(),
        locked: json['locked'] == true,
      );
}

/// Secret collection PIN handover. All rules live in the database
/// (`sales.get_my_collection_pin`, `sales.confirm_collection_with_pin`): only
/// the ordering customer can read the PIN, only the order's Dispatcher can
/// confirm it, and wrong attempts are counted and locked server-side.
class CollectionPinRepository {
  CollectionPinRepository(this._auth, this._client);

  final AuthRepository _auth;
  final SupabaseClient _client;

  Future<Either<EESUpException, CollectionPin>> getMyPin(int orderId) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client
          .schema('sales')
          .rpc('get_my_collection_pin', params: {'_order_id': orderId});
      return CollectionPin.fromJson(Map<String, dynamic>.from(res as Map));
    });
  }

  Future<Either<EESUpException, CollectionPinResult>> confirmCollection(
    int orderId,
    String pin,
  ) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client.schema('sales').rpc(
        'confirm_collection_with_pin',
        params: {'_order_id': orderId, '_pin': pin.trim()},
      );
      return CollectionPinResult.fromJson(
          Map<String, dynamic>.from(res as Map));
    });
  }
}
