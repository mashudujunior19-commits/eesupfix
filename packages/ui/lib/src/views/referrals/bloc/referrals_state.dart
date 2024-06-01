part of 'referrals_bloc.dart';

@immutable
sealed class ReferralsState {}

final class ReferralsLoading extends ReferralsState {}

final class ReferralsError extends ReferralsState {
  final EESUpException exception;
  ReferralsError(this.exception);
}

final class ReferralsLoaded extends ReferralsState {
  final List<Referral> referrals;
  ReferralsLoaded(this.referrals);
}
