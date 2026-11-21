import 'package:bloc/bloc.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/shopping/repository/hamper_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';

part 'hamper_event.dart';
part 'hamper_state.dart';

/// Loads hampers for the list and the detail page. Each screen needs one
/// database call, and every failure ends in [HamperError] so the screen can
/// show it and offer a retry.
class HamperBloc extends Bloc<HamperEvent, HamperState> {
  final ShoppingRepository _repository;

  HamperBloc(this._repository) : super(HamperInitial()) {
    on<LoadHampers>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHamperOffers();
      result.fold(
        (error) => emit(HamperError(error.message)),
        (hampers) => emit(HampersLoaded(hampers)),
      );
    });

    on<LoadHamper>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHamperOffer(event.hamperId);
      result.fold(
        (error) => emit(HamperError(error.message)),
        (hamper) => emit(
          hamper == null ? HamperNotFound() : HamperLoaded(hamper),
        ),
      );
    });
  }
}
