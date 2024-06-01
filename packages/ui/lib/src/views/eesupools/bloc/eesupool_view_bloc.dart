import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/foundation.dart';

part 'eesupool_view_event.dart';
part 'eesupool_view_state.dart';

class EESUpoolViewBloc extends Bloc<EESUpoolViewEvent, EESUpoolViewState> {
  final EESUpoolRepository _eesupoolRepo;
  EESUpoolViewBloc(this._eesupoolRepo) : super(EESUpoolViewLoading()) {
    on<EESUpoolViewLoaded>((event, emit) {
      emit(EESUpoolViewLoading());
      if (event.eesupool != null) {
        emit(CurrentEESUpoolView(event.eesupool!));
      } else {
        //TODO: fetch pool by id
      }
    });

    on<EESUpoolSettingsUpdated>((event, emit) {
      emit(CurrentEESUpoolView(event.pool));

      //Save changes
      _eesupoolRepo.updateEESUpool(event.pool);
    });

    on<EESUpoolPercentagesUpdated>((event, emit) {
      emit(CurrentEESUpoolView(event.pool));
      if (_feesBalanced(event.pool)) {
        if (kDebugMode) {
          print('#################### Saving changes #################');
        }
        //Save changes
        _eesupoolRepo.updateEESUpool(event.pool);
      }
    });
  }

  bool _feesBalanced(EESUpool pool) {
    double perc = (pool.adminFee ?? 0) +
        (pool.receivingFee ?? 0) +
        (pool.packagingFee ?? 0) +
        (pool.collectionFee ?? 0);
    final value = perc == 100.00;

    return value;
  }
}
