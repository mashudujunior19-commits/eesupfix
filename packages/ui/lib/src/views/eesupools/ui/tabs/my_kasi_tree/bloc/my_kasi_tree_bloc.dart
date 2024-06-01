import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'my_kasi_tree_event.dart';
part 'my_kasi_tree_state.dart';

class MyKasiTreeBloc extends Bloc<MyKasiTreeEvent, MyKasiTreeState> {
  final EESUpoolRepository _repository;
  MyKasiTreeBloc(this._repository) : super(MyKasiTreeLoading()) {
    on<MyKasiTreeFetched>((event, emit) async {
      emit(MyKasiTreeLoading());
      final results = await _repository.fetchEESUpoolsDescendents(
        poolId: event.parentId,
        limit: 1000,
      );
      results.fold((left) {
        emit(MyKasiTreeError(left));
      }, (right) {
        emit(MyKasiTreeLoaded(right));
      });
    });
  }
}
