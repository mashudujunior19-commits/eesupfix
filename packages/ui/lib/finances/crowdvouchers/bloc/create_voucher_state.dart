part of 'create_voucher_bloc.dart';

@immutable
sealed class CreateVoucherState {}

final class CreateVoucherCurrentState extends CreateVoucherState {
  final Voucher voucher;
  CreateVoucherCurrentState(this.voucher);
}

final class CreateVoucherBusyState extends CreateVoucherState {}


final class CreateVoucherErrorState extends CreateVoucherState {
  final EESUpException exception;
  CreateVoucherErrorState(this.exception);
}


final class CreateVoucherSuccessState extends CreateVoucherState {
  final int voucherId;
  CreateVoucherSuccessState(this.voucherId);
}




