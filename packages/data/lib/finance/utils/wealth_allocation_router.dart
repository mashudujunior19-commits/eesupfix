import 'package:data/auth/models/profile.dart';

/// Wallet `type_id` of EESUp's own house account. Wealth allocations for
/// members who can't hold a personal Wealth wallet are routed here instead
/// of being dropped.
const String eesupDefaultAccountWalletTypeId = 'eesup_default';

/// Wallet `type_id` of a member's personal Wealth wallet.
const String wealthWalletTypeId = 'wealth';

/// Resolves which wallet a "Wealth" allocation should actually be credited
/// to for [profile].
///
/// Unverified (non-SA) members can't hold a personal Wealth wallet — it's
/// gated by [Wallet.requireRsaId] the same way the Wealth wallet is hidden
/// from their "My Wallet" screen — so their share is redirected to EESUp's
/// default account instead of a wallet they don't have.
///
/// This is the single rule to call out wherever Wealth allocations are
/// actually credited (e.g. the order/profit-allocation processing routine).
String resolveWealthAllocationWalletTypeId(Profile profile) {
  return profile.isVerified ? wealthWalletTypeId : eesupDefaultAccountWalletTypeId;
}
