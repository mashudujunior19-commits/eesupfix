class AddressSuggestion {
  final String address;
  final double lat;
  final double lng;
  final String? streetNumber;
  final String? streetName;
  final String? suburb;
  final String? city;
  final String? postalCode;
  final String? province;

  const AddressSuggestion({
    required this.address,
    required this.lat,
    required this.lng,
    this.streetNumber,
    this.streetName,
    this.suburb,
    this.city,
    this.postalCode,
    this.province,
  });
}
