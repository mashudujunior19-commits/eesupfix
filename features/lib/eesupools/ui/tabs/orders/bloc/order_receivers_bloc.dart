import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'order_receivers_event.dart';
part 'order_receivers_state.dart';

class OrderReceiversBloc
    extends Bloc<OrderReceiversEvent, OrderReceiversState> {
  final EESUpoolRepository _repository;
  OrderReceiversBloc(this._repository) : super(OrderReceiversLoading()) {
    on<OrderReceiversFetched>((event, emit) async {
      final results = await _repository.fetchEESUpoolMembersByIdsArray(
        event.receivers,
      );
      results.fold((left) {
        emit(OrderReceiversError(left));
      }, (right) {
        emit(OrderReceiversLoaded(right));
      });
    });

    on<OrderReceiverAdded>((event, emit) {
      if (state is OrderReceiversLoaded) {
        List<EESUpoolMember> receivers = [
          ...(state as OrderReceiversLoaded).receivers
        ];
        if (!receivers.contains(event.member)) {
          receivers.add(event.member);
          final ids = receivers.map((e) => e.memberId).toList();
          _repository.updatePoolOrderReceivers(event.orderId, ids);
          emit(OrderReceiversLoaded(receivers));
        }
      }
    });

    on<OrderReceiverRemoved>((event, emit) {
      if (state is OrderReceiversLoaded) {
        List<EESUpoolMember> receivers = [
          ...(state as OrderReceiversLoaded).receivers
        ];
        receivers.remove(event.member);
        final ids = receivers.map((e) => e.memberId).toList();
        _repository.updatePoolOrderReceivers(event.orderId, ids);
        emit(OrderReceiversLoaded(receivers));
      }
    });
  }
}
