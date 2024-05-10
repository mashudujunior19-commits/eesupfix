import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupreneur/models/eesupreneur.dart';
import 'package:meta/meta.dart';
import 'package:repository/partners/eesupreneur_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'kasipreneur_event.dart';
part 'kasipreneur_state.dart';

class KasipreneurBloc extends Bloc<KasipreneurEvent, KasipreneurState> {
  final EESUpreneurRepository _prenerRepo;
  KasipreneurBloc(this._prenerRepo) : super(KasipreneurInitial()) {
    on<KasipreneurFetched>((event, emit) async {
      final results = await _prenerRepo.fetchUserKasipreneurs();
      results.fold((l) {
        emit(KasipreneursError(l));
      }, (r) {
        emit(KasipreneursLoaded(r));
      });
    });
  }
}
