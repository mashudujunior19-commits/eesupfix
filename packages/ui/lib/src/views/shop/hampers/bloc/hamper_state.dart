part of 'hamper_bloc.dart';

@immutable
sealed class HamperState {}

final class HamperInitial extends HamperState {}

class HamperLoading extends HamperState {}

class HampersLoaded extends HamperState {
  final List<HamperOffer> hampers;
  HampersLoaded(this.hampers);
}

class HamperLoaded extends HamperState {
  final HamperOffer hamper;
  HamperLoaded(this.hamper);
}

/// The hamper does not exist, has ended, or is not meant for this user.
class HamperNotFound extends HamperState {}

class HamperError extends HamperState {
  final String message;
  HamperError(this.message);
}
