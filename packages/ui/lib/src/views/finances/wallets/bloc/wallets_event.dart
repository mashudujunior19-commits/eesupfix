part of 'wallets_bloc.dart';

@immutable
sealed class WalletsEvent {}

/// Wallet visibility: a verified South African individual sees every wallet;
/// unverified users and corporate accounts only see Retail and Social.
final class WalletsFetched extends WalletsEvent {
  final bool isVerified;
  final bool isCorporate;
  WalletsFetched({required this.isVerified, this.isCorporate = false});
}
