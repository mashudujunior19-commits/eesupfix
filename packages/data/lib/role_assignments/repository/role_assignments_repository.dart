import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/role_assignments/data_source/role_assignments_data_source.dart';
import 'package:data/role_assignments/models/checklist_item.dart';
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
}
