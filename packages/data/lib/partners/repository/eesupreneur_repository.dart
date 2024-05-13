import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/eesupreneur/data_source/eesupreneur_data_source.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/orders/models/order.dart' as ord;

class EESUpreneurRepository {
  final EESUpreneurDataSource dataSource;
  final AuthRepository authRepo;

  EESUpreneurRepository(this.dataSource, this.authRepo);

  Future<Either<EESUpException, List<EESUpreneur>>> getClosestEESUpreneurs(
    double? lat,
    double? lng,
    int limit,
  ) async {
    if (lat == null || lng == null) {
      return const Right([]);
    }
    final result = await authRepo.executeFutureWithAuth((_) {
      return dataSource.getClosestEESUpreneurs(lat, lng, limit);
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpreneur>>>
      fetchUserKasipreneurs() async {
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
