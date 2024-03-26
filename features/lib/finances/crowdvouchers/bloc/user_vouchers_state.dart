part of 'user_vouchers_bloc.dart';

@immutable
sealed class UserVouchersState {}

final class UserVouchersBusyState extends UserVouchersState {}

final class UserVouchersErrorState extends UserVouchersState {
  final EESUpException error;
  UserVouchersErrorState(this.error);
}

final class UserVouchersLoadedState extends UserVouchersState {
  final List<Voucher> vouchers;
  UserVouchersLoadedState(this.vouchers);
}
