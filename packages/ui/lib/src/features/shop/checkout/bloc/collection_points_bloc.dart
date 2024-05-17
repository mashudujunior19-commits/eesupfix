import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/partners/repository/eesupreneur_repository.dart';
import 'package:meta/meta.dart';

part 'collection_points_event.dart';
part 'collection_points_state.dart';

class CollectionPointsBloc
    extends Bloc<CollectionPointsEvent, CollectionPointsState> {
  final EESUpreneurRepository _eesuPreneurRepo;
  final EESUpoolRepository _eesuPoolRepo;
  CollectionPointsBloc(this._eesuPreneurRepo, this._eesuPoolRepo)
      : super(CollectionPointsLoading()) {
    on<CollectionPointsRequested>((event, emit) async {
      late final List<EESUpreneur> shops;
      late final List<EESUpoolOrder> orders;

      final lat = event.address?.latitude;
      final lng = event.address?.longitude;

      final shopsRes =
          await _eesuPreneurRepo.getClosestEESUpreneurs(lat, lng, 50);
      final ordesRes = await _eesuPoolRepo.fetchOpenEESUpoolOrders();

      shopsRes.fold((l) => null, (r) {
        shops = r;
      });

      ordesRes.fold((l) => null, (r) {
        orders = r;
      });

      emit(CollectionPointsLoaded(shops, orders));
    });
  }
}
