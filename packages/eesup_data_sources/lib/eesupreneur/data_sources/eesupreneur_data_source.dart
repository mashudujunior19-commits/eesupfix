import 'package:eesup_data_source/eesupreneur/models/eesupreneur.dart';
import 'package:eesup_data_source/orders/models/order.dart';


abstract class EESUpreneurDataSource {
  ///given lat and lng, return a list of EESUpreneurs
  Future<List<EESUpreneur>> getClosestEESUpreneurs(
      double lat, double lng, int limit);

  Future<List<EESUpreneur>> getUserEESUpreneurs(String userId);

  Future<List<Order>> fetchEESUpreneurOrders(
    String eesupreneurId,
    List<OrderStatus> statuses,
  );

  Future<bool> saveChanges(EESUpreneur eesupreneur);
}
