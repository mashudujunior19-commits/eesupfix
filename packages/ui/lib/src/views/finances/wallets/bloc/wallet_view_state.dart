part of 'wallet_view_bloc.dart';

@immutable
sealed class WalletViewState {}

final class WalletViewInitial extends WalletViewState {}

final class WalletViewError extends WalletViewState {
  final EESUpException exception;
  WalletViewError(this.exception);
}

final class WalletViewLoaded extends WalletViewState {
  final Wallet wallet;
  final List<Transaction> transactions;
  WalletViewLoaded(this.wallet, this.transactions);
}

class WalletBalancesLoaded extends WalletViewState {
  final List<WalletBalance> balances;
  WalletBalancesLoaded(this.balances);
}
