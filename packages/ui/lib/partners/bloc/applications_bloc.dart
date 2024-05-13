import 'package:bloc/bloc.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'applications_event.dart';
part 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final PartnerRepository _repository;
  ApplicationsBloc(this._repository) : super(ApplicationsLoading()) {
    on<ApplicationsFetched>((event, emit) async {
      final results = await _repository.fetchPartnerApplications(event.id);
      results.fold((left) {
        emit(ApplicationsError(left));
      }, (right) {
        emit(ApplicationsLoaded(right));
      });
    });
  }
}
