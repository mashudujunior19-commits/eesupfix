/// An approved KasiLift Organisation a Social wallet can transfer to.
/// [walletId] is the organisation owner's Income wallet.
class KasiliftOrganisation {
  final String organisationId;
  final String name;
  final String? province;
  final int walletId;

  const KasiliftOrganisation({
    required this.organisationId,
    required this.name,
    this.province,
    required this.walletId,
  });

  factory KasiliftOrganisation.fromJson(Map<String, dynamic> json) {
    return KasiliftOrganisation(
      organisationId: json['organisation_id'] as String,
      name: json['organisation_name'] as String,
      province: json['province'] as String?,
      walletId: json['wallet_id'] as int,
    );
  }
}
