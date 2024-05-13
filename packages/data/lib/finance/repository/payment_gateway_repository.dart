import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/finance/data_source/wallet_data_source.dart';
import 'package:data/finance/models/payment_gateway.dart';

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
