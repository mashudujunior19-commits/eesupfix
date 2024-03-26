part of 'crowdfund_voucher_bloc.dart';

@immutable
sealed class CrowdfundVoucherEvent {}

final class CrowdfundVoucherLoadEvent extends CrowdfundVoucherEvent {
  CrowdfundVoucherLoadEvent();
}
