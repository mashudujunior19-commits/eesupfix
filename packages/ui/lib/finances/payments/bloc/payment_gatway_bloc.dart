import 'package:bloc/bloc.dart';
import 'package:data/finance/models/payment_gateway.dart';
import 'package:data/finance/models/payment_method.dart';
import 'package:data/finance/repository/payment_gateway_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'payment_gatway_event.dart';
part 'payment_gatway_state.dart';

class PaymentGatwayBloc extends Bloc<PaymentGatwayEvent, PaymentGatwayState> {
  final PaymentGatewayRepo _gatewayRepo;
  PaymentGatwayBloc(this._gatewayRepo) : super(PaymentGaywayLoading()) {
    on<PaymentGatewaysFetched>((event, emit) async {
      final results = await _gatewayRepo.fetchPaymentGayways();
      results.fold((l) {
        emit(PaymentGatwaysError(l));
      }, (r) {
        emit(PaymentGatwaysLoaded(r));
      });
    });
  }
}
