import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'otp_auth_event.dart';
part 'otp_auth_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  // ignore: unused_field
  final AuthRepository _authRepository;
  OtpAuthBloc(this._authRepository) : super(OtpAuthInitial()) {
    on<OtpAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
