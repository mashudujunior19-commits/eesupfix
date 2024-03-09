part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AppStarted extends AuthEvent {
  AppStarted();
}

final class SignInPressed extends AuthEvent {
  SignInPressed(this.email, this.phone, this.password);
  final String? email;
  final String? phone;
  final String password;
}

final class SignOutPressed extends AuthEvent {
  SignOutPressed();
}
