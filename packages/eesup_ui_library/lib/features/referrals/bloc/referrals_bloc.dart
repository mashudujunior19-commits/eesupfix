import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'referrals_event.dart';
part 'referrals_state.dart';

class ReferralsBloc extends Bloc<ReferralsEvent, ReferralsState> {
  ReferralsBloc() : super(ReferralsInitial()) {
    on<ReferralsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
