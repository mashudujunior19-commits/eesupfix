part of 'voucher_view_bloc.dart';

@immutable
sealed class VoucherViewState {}

final class VoucherViewBusyState extends VoucherViewState {}

final class VoucherViewErrorState extends VoucherViewState {
  final EESUpException error;
  VoucherViewErrorState(this.error);
}

final class VoucherViewDetailsLoadedState extends VoucherViewState {
  final Voucher voucher;
  final VoucherParameter parameter;
  final List<Transaction> transactions;
  final List<VoucherLedger> ledgers;
  VoucherViewDetailsLoadedState(this.voucher, this.transactions, this.ledgers, this.parameter);
}
