import 'package:bloc/bloc.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'partners_event.dart';
part 'partners_state.dart';

class PartnersBloc extends Bloc<PartnersEvent, PartnersState> {
  final PartnerRepository _repository;
  PartnersBloc(this._repository) : super(PartnersLoading()) {
    on<PartnersFetched>((event, emit) async {
      emit(PartnersLoading());
      final results = await _repository.fetchPartnerships(event.role);
      results.fold((left) {
        emit(PartnersError(left));
      }, (right) {
        emit(PartnersLoaded(right.where((p) => !_isHidden(p)).toList()));
      });
    });
  }

  /// Spaza and KasiPreneur partnerships are no longer offered through
  /// "Get Involved", so they're dropped even if still open server-side.
  static const _hiddenPartnerKeywords = ['spaza', 'kasipreneur', 'eesupreneur'];

  static bool _isHidden(Partner partner) {
    final title = partner.title.toLowerCase().replaceAll(RegExp(r'[\s-]'), '');
    return _hiddenPartnerKeywords.any(title.contains);
  }
}
