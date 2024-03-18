bool isValidSouthAfricanID(String id) {
    // Basic regex pattern to match 13 digits
    RegExp regex = RegExp(r'^\d{13}$');

    // Check if the ID matches the basic pattern
    if (!regex.hasMatch(id)) {
      return false;
    }

    // Validate the date
    int month = int.parse(id.substring(2, 4));
    int day = int.parse(id.substring(4, 6));
    // Simple check for month and day validity
    bool isValidDate = (month > 0 && month <= 12) && (day > 0 && day <= 31);

    if (!isValidDate) {
      return false;
    }

    // Calculate checksum using the modified Luhn algorithm
    int sum = 0;
    for (int i = 0; i < 13; i++) {
      int digit = int.parse(id[i]);
      if (i % 2 == 0) {
        sum += digit; // Odd positions (considered as even in 0-indexed loop)
      } else {
        int doubleDigit = digit * 2;
        sum +=
            (doubleDigit > 9) ? doubleDigit - 9 : doubleDigit; // Even positions
      }
    }

    // Validate checksum
    return sum % 10 == 0;
  }