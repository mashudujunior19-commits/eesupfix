import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/eesupool_settings.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';

part 'pool_order_view_event.dart';
part 'pool_order_view_state.dart';

class PoolOrderViewBloc extends Bloc<PoolOrderViewEvent, PoolOrderViewState> {
  // ignore: unused_field
  final EESUpoolRepository _repository;
  PoolOrderViewBloc(this._repository) : super(PoolOrderViewLoading()) {
    on<PoolOrderInitialized>((event, emit) {
      emit(PoolOrderViewCurrentState(event.order));
    });

    on<PoolOrderIsReceived>((event, emit) {
      if (state is PoolOrderViewCurrentState) {
        final current = (state as PoolOrderViewCurrentState).pooOrder;
        _repository.updateOrder(current.copyWith(deliveredAt: event.now));
        emit(
          PoolOrderViewCurrentState(current.copyWith(deliveredAt: event.now)),
        );
      }
    });
    // on<PoolOrderIsReceived>((event, emit) async {
    //   if (state is PoolOrderViewCurrentState) {
    //     final current = (state as PoolOrderViewCurrentState).pooOrder;

    //     final settingsResult = await _repository.fetchEESUpoolSettings();

    //     settingsResult.fold(
    //       (error) {
    //         emit(PoolOrderViewError(error.message));
    //       },
    //       (settings) async {
    //         await _repository
    //             .updateOrder(current.copyWith(deliveredAt: event.now));

    //         emit(PoolOrderViewCurrentState(
    //           current.copyWith(deliveredAt: event.now)
    //         ));
    //       },
    //     );
    //   }
    // });

    on<PoolOrderUpdated>((event, emit) async {
      final res = await _repository.updateOrder(event.order);
      print(res.right);
      emit(PoolOrderViewCurrentState(event.order));
    });
    on<FetchEESUpoolSettings>((event, emit) async {
      emit(PoolOrderViewLoading());
      final result = await _repository.fetchEESUpoolSettings();
      result.fold(
        (error) => emit(PoolOrderViewError(error.message)),
        (settings) {
          if (settings != null) {
            emit(EESUpoolSettingsLoaded(settings));
          } else {
            emit(PoolOrderViewError("No settings found."));
          }
        },
      );
    });

    on<ExtendOrderDeadline>((event, emit) {
      if (state is PoolOrderViewCurrentState) {
        final currentOrder = (state as PoolOrderViewCurrentState).pooOrder;
        final updatedOrder = currentOrder.copyWith(
          closesAt: currentOrder.closesAt.add(const Duration(days: 1)),
        );

        _repository.updateOrder(updatedOrder); // Persist the change
        emit(PoolOrderViewCurrentState(updatedOrder));
      }
    });

    on<CancelOrder>((event, emit) async {
      if (state is EESUpoolSettingsLoaded) {
        final settings = (state as EESUpoolSettingsLoaded).settings;

        if (settings.userCount == 2) {
          emit(ShowPopup("Add another admin before canceling."));
        } else if (settings.userCount == 3) {
          emit(ShowPopup(
              "You've reached the max cancelation count. You will be removed as an admin."));
          await _repository.removeAdmin(event.poolId);
        } else {
          await _repository.updateMemberCount(event.orderId, event.poolId);
          emit(OrderCancelled());
        }
      } else {
        emit(PoolOrderViewError("Failed to fetch settings."));
      }
    });
  }
}
