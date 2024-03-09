String? localizeSAPhoneNumber(String phoneNumber) {
  if(phoneNumber.isEmpty) {
    return null;
  }
  // Remove any leading + sign
  String normalizedNumber = phoneNumber.replaceAll(RegExp(r'^\+'), ''); // Remove + if present

  // Replace leading 0 with 27 if the number doesn't already start with 27
  if (!normalizedNumber.startsWith('27')) {
    if (normalizedNumber.startsWith('0')) {
      normalizedNumber = '27${normalizedNumber.substring(1)}';
    } else {
      normalizedNumber = '27$normalizedNumber';
    }
  }

  // Ensure the number starts with 27 and remove any leading 0 after the 27 if present
  if (normalizedNumber.startsWith('270')) {
    normalizedNumber = '27${normalizedNumber.substring(3)}';
  }

  // Validate final number length to be 11 digits (country code + phone number)
  // Return null if the validation fails
  if (normalizedNumber.length != 11) {
    return null;
  }

  return normalizedNumber;
}
