part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class UnAuthenticated extends AuthBlocState {}

final class Authenticated extends AuthBlocState {
  final bool isStartUp;
  Authenticated(this.isStartUp);
}

final class AuthLoading extends AuthBlocState {}

final class AuthError extends AuthBlocState {
  AuthError(this.error);
  final EESUpException error;
}
