/// Builds the link and message a user sends to invite someone with their
/// referral code.
///
/// The Android link is the Play Store listing with the code in Google
/// Play's `referrer` parameter (`referral_code=<code>`), so it survives the
/// install. The code is always in the message text too, since iOS and
/// Huawei don't pass a referrer through and new users enter it at sign-up.
class ReferralLink {
  const ReferralLink({
    required this.code,
    this.androidStoreUrl,
    this.iosStoreUrl,
  });

  final int code;
  final String? androidStoreUrl;
  final String? iosStoreUrl;

  /// The Play Store link carrying the referral code, or null when the store
  /// URL isn't known.
  String? get androidLink {
    final uri = _parse(androidStoreUrl);
    if (uri == null) return null;
    return uri.replace(queryParameters: {
      ...uri.queryParameters,
      'referrer': 'referral_code=$code',
    }).toString();
  }

  String? get iosLink => _parse(iosStoreUrl)?.toString();

  /// The ready-to-send invite text.
  String get message {
    final links = [
      if (androidLink != null) 'Android: $androidLink',
      if (iosLink != null) 'iPhone: $iosLink',
    ];
    return [
      'Join me on EESUp! Sign up with my referral code $code.',
      if (links.isNotEmpty) 'Download the app:\n${links.join('\n')}',
    ].join('\n\n');
  }

  static Uri? _parse(String? url) {
    if (url == null || url.trim().isEmpty) return null;
    final uri = Uri.tryParse(url.trim());
    return uri != null && uri.hasScheme ? uri : null;
  }
}
