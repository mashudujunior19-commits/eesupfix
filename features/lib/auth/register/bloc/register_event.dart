part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterFormUpdated extends RegisterEvent {
  final RegisterFormState stateCopy;
  RegisterFormUpdated(this.stateCopy);
}
