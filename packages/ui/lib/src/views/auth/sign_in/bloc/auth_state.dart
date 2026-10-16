part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class UnAuthenticated extends AuthBlocState {}

final class Authenticated extends AuthBlocState {
  final bool isStartUp;
  Authenticated(this.isStartUp);
}

/// A password-recovery session is active but the user never finished
/// setting a new password (e.g. the app was closed mid-reset). This is
/// deliberately distinct from [Authenticated] -- a leftover recovery
/// session must never be treated as a normal signed-in session.
final class PasswordResetPending extends AuthBlocState {
  final String? email;
  final String? phone;
  PasswordResetPending({this.email, this.phone});
}

final class AuthLoading extends AuthBlocState {}

final class AuthError extends AuthBlocState {
  AuthError(this.error);
  final EESUpException error;
}
