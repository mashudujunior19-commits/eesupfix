import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:repository/utils/validate_id_number.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationFormState> {
  RegistrationBloc() : super(SignUpForm()) {
    on<SignUpFormUpdated>((event, emit) {
      emit(event.signUpForm);
      if (kDebugMode) {
        print(event.signUpForm.toJson());
      }
    });
  }
}
