import 'package:dartz/dartz.dart';
import 'package:data_sources/finance/data_source/wallet_data_source.dart';
import 'package:data_sources/finance/models/payment_gateway.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class PaymentGatewayRepo {
  final WalletDataSource _dataSource;
  final AuthRepository _authRepo;
  PaymentGatewayRepo(this._authRepo, this._dataSource);

  Future<Either<EESUpException, List<PaymentGateway>>>
      fetchPaymentGayways() async {
    final results = await _authRepo.executeFutureWithAuth((id) {
      return _dataSource.fetchPaymentGateways();
    });
    return results;
  }
}
