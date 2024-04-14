import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:repository/utils/validate_id_number.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterFormState()) {
    on<RegisterFormUpdated>((event, emit) {
      emit(event.stateCopy);
    });
  }
}
