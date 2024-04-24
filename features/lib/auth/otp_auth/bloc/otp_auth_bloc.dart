import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'otp_auth_event.dart';
part 'otp_auth_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  final AuthRepository _authRepository;
  OtpAuthBloc(this._authRepository) : super(OtpAuthInitial()) {
    on<OtpAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
