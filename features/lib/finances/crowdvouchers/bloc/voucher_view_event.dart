part of 'voucher_view_bloc.dart';

@immutable
sealed class VoucherViewEvent {}

final class FetchVoucherDetailsEvent extends VoucherViewEvent {
  final int voucherId;
  FetchVoucherDetailsEvent(this.voucherId);
}
