/// South African CIPC company registration number, e.g. "2021/123456/07".
bool isValidCompanyRegistrationNumber(String value) {
  final RegExp regex = RegExp(r'^\d{4}/\d{6}/\d{2}$');
  return regex.hasMatch(value.trim());
}

/// South African VAT number: 10 digits, starting with 4.
bool isValidVATNumber(String value) {
  final RegExp regex = RegExp(r'^4\d{9}$');
  return regex.hasMatch(value.trim());
}

/// SARS Public Benefit Organisation (PBO) number, e.g. "930012345".
bool isValidPBONumber(String value) {
  final RegExp regex = RegExp(r'^\d{9}$');
  return regex.hasMatch(value.trim());
}

/// Local (0xxxxxxxxx) or international (27xxxxxxxxx) South African
/// phone/cell number.
bool isValidSouthAfricanPhoneOrCell(String value) {
  final RegExp regex = RegExp(r'^(0\d{9}|27\d{9})$');
  return regex.hasMatch(value.trim());
}
