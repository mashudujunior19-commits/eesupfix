part of 'create_voucher_bloc.dart';

@immutable
sealed class CreateVoucherEvent {}

final class CreateVoucherUpdatedEvent extends CreateVoucherEvent {
  final Voucher voucher;
  CreateVoucherUpdatedEvent(this.voucher);
}

final class SubmitVoucherEvent extends CreateVoucherEvent {
  final Voucher voucher;
  SubmitVoucherEvent(this.voucher);
}
