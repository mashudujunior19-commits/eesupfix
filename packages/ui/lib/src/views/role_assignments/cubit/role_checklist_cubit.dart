import 'package:data/role_assignments/models/checklist_item.dart';
import 'package:data/role_assignments/repository/role_assignments_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class RoleChecklistState {}

final class RoleChecklistLoading extends RoleChecklistState {}

final class RoleChecklistError extends RoleChecklistState {
  final EESUpException exception;
  RoleChecklistError(this.exception);
}

final class RoleChecklistLoaded extends RoleChecklistState {
  final List<ChecklistItem> items;

  /// Set when the last tick couldn't be saved (the tick is rolled back).
  final String? saveError;
  RoleChecklistLoaded(this.items, {this.saveError});

  int get checkedCount => items.where((e) => e.isChecked).length;
}

class RoleChecklistCubit extends Cubit<RoleChecklistState> {
  RoleChecklistCubit(this._repository, this.eesupoolOrderId, this.orderId)
      : super(RoleChecklistLoading());

  final RoleAssignmentsRepository _repository;
  final int eesupoolOrderId;
  final int? orderId;

  Future<void> load() async {
    emit(RoleChecklistLoading());
    final result = await _repository.fetchChecklist(eesupoolOrderId, orderId);
    result.fold(
      (l) => emit(RoleChecklistError(l)),
      (r) => emit(RoleChecklistLoaded(r)),
    );
  }

  Future<void> toggle(ChecklistItem item) async {
    final current = state;
    if (current is! RoleChecklistLoaded) return;

    final checked = !item.isChecked;
    List<ChecklistItem> withTick(bool value) => [
          for (final i in (state as RoleChecklistLoaded).items)
            i.productId == item.productId ? i.copyWith(isChecked: value) : i,
        ];

    emit(RoleChecklistLoaded(withTick(checked)));
    final result = await _repository.setChecklistItem(
      eesupoolOrderId: eesupoolOrderId,
      orderId: orderId,
      productId: item.productId,
      checked: checked,
    );
    result.fold(
      (l) => emit(RoleChecklistLoaded(withTick(!checked), saveError: l.message)),
      (_) {},
    );
  }
}
