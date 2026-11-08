import 'package:data/finance/models/wallet.dart';

/// What a wallet is allowed to do. The database enforces the same rules;
/// this only decides what the app offers.
///
/// Wallet types are the `type_id` values: retail, income, wealth, social.
const double minWealthCommitBalance = 500;

extension WalletRules on Wallet {
  bool get isSocial => typeId == 'social';
  bool get isWealth => typeId == 'wealth';

  /// Social and Wealth funds can never be paid out as cash.
  bool get canRequestPayout => !isSocial && !isWealth;

  /// Wealth funds are committed to projects instead of transferred.
  bool get canTransfer => !isWealth;
  bool get canCommit => isWealth;
}

/// Wealth wallets can commit only while the available balance is strictly
/// more than [minWealthCommitBalance].
bool canCommitWithBalance(double availableBalance) =>
    availableBalance > minWealthCommitBalance;
