part of 'otp_auth_bloc.dart';

@immutable
sealed class OtpAuthState {}

final class OtpAuthInitial extends OtpAuthState {}

final class OtpAuthLoading extends OtpAuthState {}

final class OtpAuthSuccess extends OtpAuthState {}

final class OtpAuthFailure extends OtpAuthState {
  final EESUpException error;
  OtpAuthFailure(this.error);
}

// final class OtpAuthCurrentState extends OtpAuthState {
//   final String? email;
//   final String? phone;
//   OtpAuthCurrentState(this.email, this.phone);
// }
