part of 'user_vouchers_bloc.dart';

@immutable
sealed class UserVouchersEvent {}

final class FetchUserVouchersEvent extends UserVouchersEvent {}
