import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:data/utils/validate_id_number.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationFormState> {
  final AuthRepository _repository;
  RegistrationBloc(this._repository) : super(SignUpForm()) {
    on<SignUpRestarted>((event, emit) {
      emit(event.form);
    });

    on<SignUpSubmited>((event, emit) async {
      emit(SignUpLoading());
      final results = await _repository.signUp(
        email: event.form.email,
        phone: event.form.phone,
        password: event.form.password!,
        metaData: event.form.toJson(),
      );

      results.fold((left) {
        emit(FailedToSignUp(event.form, left));
      }, (right) {
        if (right) {
          emit(AwaitingOtpAuth(event.form));
        } else {
          emit(
            FailedToSignUp(
              event.form,
              EESUpException(
                message: 'Something went wrong while proccessing your request.',
              ),
            ),
          );
        }
      });
    });

    on<CorpFormUpdated>((event, emit) {
      if (state is SignUpForm) {
        final form = (state as SignUpForm);
        emit(
          SignUpForm(
            isCorp: form.isCorp,
            corpName: event.name,
            corpReg: event.reg,
          ),
        );
      }
    });

    on<IndividualFormUpdated>((event, emit) {
      if (state is SignUpForm) {
        final form = (state as SignUpForm);
        emit(
          SignUpForm(
            isCorp: form.isCorp,
            agreedToTcsAndCs: form.agreedToTcsAndCs,
            isRSACitizen: event.isRSACitizen,
            isPasswordValid: form.isPasswordValid,
            email: form.email,
            phone: form.phone,
            referralCode: form.referralCode,
            password: form.password,
            retypedPassword: form.retypedPassword,
            firstName: event.firstName,
            lastName: event.lastName,
            dob: event.dob,
            idNumber: event.idNumber,
          ),
        );
      }
    });

    on<AccountTypeUpdated>((event, emit) {
      emit(SignUpForm(isCorp: event.isCorp));
    });

    on<CredentialsUpdated>((event, emit) {
      if (state is SignUpForm) {
        final form = (state as SignUpForm);
        emit(
          SignUpForm(
            isCorp: form.isCorp,
            agreedToTcsAndCs: form.agreedToTcsAndCs,
            isRSACitizen: form.isRSACitizen,
            isPasswordValid: form.isPasswordValid,
            corpName: form.corpName,
            corpReg: form.corpReg,
            email: event.email,
            phone: event.phone,
            referralCode: form.referralCode,
            password: event.password,
            retypedPassword: event.retypedPassword,
            firstName: form.firstName,
            lastName: form.lastName,
            dob: form.dob,
            idNumber: form.idNumber,
          ),
        );
      }
    });

    on<ReferralCodeUpdated>((event, emit) {
      if (state is SignUpForm) {
        final form = (state as SignUpForm);
        emit(
          SignUpForm(
            isCorp: form.isCorp,
            agreedToTcsAndCs: event.acceptedTsAndCs,
            isRSACitizen: form.isRSACitizen,
            isPasswordValid: form.isPasswordValid,
            corpName: form.corpName,
            corpReg: form.corpReg,
            email: form.email,
            phone: form.phone,
            referralCode: event.code,
            password: form.password,
            retypedPassword: form.retypedPassword,
            firstName: form.firstName,
            lastName: form.lastName,
            dob: form.dob,
            idNumber: form.idNumber,
          ),
        );
      }
    });
  }
}


//  emit(
//           SignUpForm(
//             isCorp: form.isCorp,
//             agreedToTcsAndCs: form.agreedToTcsAndCs,
//             isRSACitizen: form.isRSACitizen,
//             isPasswordValid: form.isPasswordValid,
//             corpName: form.corpName,
//             corpReg: form.corpReg,
//             email: form.email,
//             phone: form.phone,
//             referralCode: form.referralCode,
//             password: form.password,
//             retypedPassword: form.retypedPassword,
//             firstName: form.firstName,
//             lastName: form.lastName,
//             dob: form.dob,
//             idNumber: form.idNumber,
//             npcCorpReg: form.npcCorpReg,
//           ),
//         );