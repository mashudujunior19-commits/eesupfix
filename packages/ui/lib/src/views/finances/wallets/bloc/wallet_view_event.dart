part of 'wallet_view_bloc.dart';

@immutable
sealed class WalletViewEvent {}

final class WalletViewFetched extends WalletViewEvent {
  final int id;
  WalletViewFetched(this.id);
}

class WalletBalancesFetched extends WalletViewEvent {}
