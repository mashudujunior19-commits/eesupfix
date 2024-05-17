part of 'referrals_bloc.dart';

@immutable
sealed class ReferralsEvent {}

final class ReferralsFetched extends ReferralsEvent{}
