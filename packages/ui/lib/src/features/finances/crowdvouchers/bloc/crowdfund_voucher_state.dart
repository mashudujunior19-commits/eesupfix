part of 'crowdfund_voucher_bloc.dart';

@immutable
sealed class CrowdfundVoucherState {}

final class CrowdfundVoucherBusyState extends CrowdfundVoucherState {}

final class CrowdfundVoucherErrorState extends CrowdfundVoucherState {
  final EESUpException error;
  CrowdfundVoucherErrorState(this.error);
}

final class CrowdfundVoucherLoadedState extends CrowdfundVoucherState {
  final Wallet wallet;
  CrowdfundVoucherLoadedState(this.wallet);
}
