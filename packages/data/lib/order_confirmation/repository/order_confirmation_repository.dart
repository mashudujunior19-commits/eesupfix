import 'dart:typed_data';

import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/order_confirmation/data_source/order_confirmation_data_source.dart';
import 'package:data/order_confirmation/models/order_confirmation.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';

class OrderConfirmationRepository {
  final AuthRepository _authRepository;
  final OrderConfirmationDataSource _dataSource;

  OrderConfirmationRepository(this._authRepository, this._dataSource);

  Future<Either<EESUpException, OrderConfirmation>> getConfirmation(
    int orderId,
  ) {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.getConfirmation(orderId),
    );
  }

  Future<Either<EESUpException, ConfirmResult>> confirm({
    required int orderId,
    required List<ConfirmationLineInput> lines,
    required String idempotencyKey,
  }) {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.confirm(
        orderId: orderId,
        lines: lines,
        idempotencyKey: idempotencyKey,
      ),
    );
  }

  /// Best effort: returns the public URL, or null if the upload failed
  /// (never throws, so it can't block a confirmation).
  Future<String?> uploadPhoto({
    required int orderId,
    required Uint8List bytes,
    required String extension,
  }) async {
    final userId = _authRepository.sessionId;
    if (userId == null) return null;
    final ext = extension.replaceAll('.', '').toLowerCase();
    final safeExt = ext.isEmpty ? 'jpg' : ext;
    final path =
        '$userId/confirm/$orderId/${DateTime.now().millisecondsSinceEpoch}.$safeExt';
    try {
      return await _dataSource.uploadPhoto(path, bytes);
    } catch (_) {
      return null;
    }
  }
}
