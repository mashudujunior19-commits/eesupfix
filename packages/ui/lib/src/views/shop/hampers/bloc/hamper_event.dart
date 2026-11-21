part of 'hamper_bloc.dart';

@immutable
sealed class HamperEvent {}

/// Load every hamper the user may see (also used to retry).
class LoadHampers extends HamperEvent {}

/// Load one hamper by id (also used to retry).
class LoadHamper extends HamperEvent {
  final String hamperId;
  LoadHamper(this.hamperId);
}
