import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/eesupreneur/data_sources/eesupreneur_data_source.dart';
import 'package:eesup_data_source/eesupreneur/models/eesupreneur.dart';
import 'package:eesup_data_source/orders/models/order.dart' as ord;
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';


class EESUpreneurRepository {
  final EESUpreneurDataSource dataSource;
  final AuthRepository authRepo;

  EESUpreneurRepository(this.dataSource, this.authRepo);

  Future<Either<EESUpException, List<EESUpreneur>>> getClosestEESUpreneurs(
    double lat,
    double lng,
    int limit,
  ) async {
    final result = await authRepo.executeFutureWithAuth((_) {
      return dataSource.getClosestEESUpreneurs(lat, lng, limit);
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpreneur>>>
      getUsertEESUpreneurs() async {
    final result = await authRepo.executeFutureWithAuth((id) {
      return dataSource.getUserEESUpreneurs(id);
    });
    return result;
  }

  Future<Either<EESUpException, List<ord.Order>>> getOrders(
      String id, List<ord.OrderStatus> statuses) async {
    final result = await authRepo.executeFutureWithAuth((_) {
      return dataSource.fetchEESUpreneurOrders(id, statuses);
    });
    return result;
  }

  Future<Either<EESUpException, bool>> saveChanges(
    EESUpreneur eesupreneur,
  ) async {
    final result = await authRepo.executeFutureWithAuth((_) {
      return dataSource.saveChanges(eesupreneur);
    });
    return result;
  }
}
