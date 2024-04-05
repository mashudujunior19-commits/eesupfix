part of 'wallets_bloc.dart';

@immutable
sealed class WalletsState {}

final class WalletsLoading extends WalletsState {}

final class WalletsLoadingError extends WalletsState {
  final EESUpException error;
  WalletsLoadingError(this.error);
}

final class WalletsLoaded extends WalletsState {
  final List<Wallet> wallets;
  WalletsLoaded(this.wallets);
}
