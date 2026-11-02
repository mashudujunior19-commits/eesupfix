import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/role_assignments/data_source/role_assignments_data_source.dart';
import 'dart:typed_data';

import 'package:data/role_assignments/models/checklist_item.dart';
import 'package:data/role_assignments/models/order_receipt.dart';
import 'package:data/role_assignments/models/role_assigned_order.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';

class RoleAssignmentsRepository {
  final AuthRepository _authRepository;
  final RoleAssignmentsDataSource _dataSource;

  RoleAssignmentsRepository(this._authRepository, this._dataSource);

  Future<Either<EESUpException, List<RoleAssignedOrder>>>
      fetchMyRoleAssignedOrders() {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.fetchMyRoleAssignedOrders(),
    );
  }

  Future<Either<EESUpException, List<ChecklistItem>>> fetchChecklist(
    int eesupoolOrderId,
    int? orderId,
  ) {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.fetchChecklist(eesupoolOrderId, orderId),
    );
  }

  Future<Either<EESUpException, void>> setChecklistItem({
    required int eesupoolOrderId,
    required int? orderId,
    required int productId,
    required bool checked,
  }) {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.setChecklistItem(
        eesupoolOrderId: eesupoolOrderId,
        orderId: orderId,
        productId: productId,
        checked: checked,
      ),
    );
  }

  Future<Either<EESUpException, ReceiptState>> fetchReceiptState(
          int eesupoolOrderId) =>
      _authRepository.executeFutureWithAuth(
          (_) => _dataSource.fetchReceiptState(eesupoolOrderId));

  Future<Either<EESUpException, List<ReceiptItem>>> fetchReceipt(
          int eesupoolOrderId) =>
      _authRepository.executeFutureWithAuth(
          (_) => _dataSource.fetchReceipt(eesupoolOrderId));

  Future<Either<EESUpException, void>> saveReceiptItem({
    required int eesupoolOrderId,
    required ReceiptItem item,
  }) =>
      _authRepository.executeFutureWithAuth((_) => _dataSource
          .saveReceiptItem(eesupoolOrderId: eesupoolOrderId, item: item));

  Future<Either<EESUpException, void>> confirmReceipt(int eesupoolOrderId) =>
      _authRepository.executeFutureWithAuth(
          (_) => _dataSource.confirmReceipt(eesupoolOrderId));

  Future<Either<EESUpException, DeliveryInfo>> fetchDeliveryInfo(
          int eesupoolOrderId) =>
      _authRepository.executeFutureWithAuth(
          (_) => _dataSource.fetchDeliveryInfo(eesupoolOrderId));

  Future<Either<EESUpException, String>> uploadFaultPhoto(
          String path, Uint8List bytes) =>
      _authRepository.executeFutureWithAuth(
          (_) => _dataSource.uploadFaultPhoto(path, bytes));
}
