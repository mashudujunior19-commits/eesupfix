part of 'wallets_bloc.dart';

@immutable
sealed class WalletsEvent {}

/// [isVerified] gates wallets that require a verified RSA ID
/// ([Wallet.requireRsaId]) — e.g. Wealth and Income wallets. Unverified
/// (non-SA) members only ever see Retail/Social-style wallets.
final class WalletsFetched extends WalletsEvent {
  final bool isVerified;
  WalletsFetched({required this.isVerified});
}
