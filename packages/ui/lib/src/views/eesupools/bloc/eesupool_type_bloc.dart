import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'eesupool_type_event.dart';
part 'eesupool_type_state.dart';

class EESUpoolTypeViewBloc
    extends Bloc<EESUpoolTypeEvent, EESUpoolTypeViewState> {
  final EESUpoolRepository eesupoolRepo;
  EESUpoolTypeViewBloc(this.eesupoolRepo) : super(EESUpoolTypeViewInitial()) {
    on<EESUpoolsTypeViewFetched>((event, emit) async {
      emit(EESUpoolTypeViewLoading());
      late final List<EESUpool> eesupools;
      late final int kasiPoolsCount;
      final eesupoolsRes = await eesupoolRepo.fetchUserEESUpools(
        event.type,
      );
      final countRes = await eesupoolRepo.countUserEESUpoolsByType(
        EESUpoolType.kasi,
      );
      eesupoolsRes.fold((l) {
        emit(EESUpoolTypeViewError(l));
      }, (r) {
        eesupools = r;
      });

      countRes.fold((l) {
        emit(EESUpoolTypeViewError(l));
      }, (r) {
        kasiPoolsCount = r;
      });
      emit(EESUpoolsTypeViewLoaded(eesupools, kasiPoolsCount));
    });
  }
}
