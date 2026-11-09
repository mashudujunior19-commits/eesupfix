/// Which profile an account can use. An approved Get Involved application
/// unlocks the Business profile; until then there is nothing to switch to.
class ProfileSwitchState {
  const ProfileSwitchState({
    required this.available,
    required this.businessActive,
    this.businessName,
  });

  /// May this account switch between its Individual and Business profile?
  final bool available;

  /// True while the Business profile is the one in use.
  final bool businessActive;

  /// The approved organisation's name.
  final String? businessName;

  static const unavailable =
      ProfileSwitchState(available: false, businessActive: false);
}
