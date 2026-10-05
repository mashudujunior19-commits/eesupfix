import 'package:flutter/material.dart';

/// Password rules for registration and password reset: an uppercase letter,
/// a lowercase letter, a number and a symbol, 8-72 characters (72 is the
/// most Supabase Auth accepts), and both entries must match.
abstract final class PasswordRules {
  static const int minLength = 8;
  static const int maxLength = 72;

  static bool hasUppercase(String p) => p.contains(RegExp(r'[A-Z]'));
  static bool hasLowercase(String p) => p.contains(RegExp(r'[a-z]'));
  static bool hasNumber(String p) => p.contains(RegExp(r'[0-9]'));

  /// Any character that isn't a letter, digit or space counts as a symbol.
  static bool hasSymbol(String p) => p.contains(RegExp(r'[^A-Za-z0-9\s]'));

  static bool hasValidLength(String p) =>
      p.length >= minLength && p.length <= maxLength;

  static bool matches(String p, String confirm) =>
      p.isNotEmpty && p == confirm;

  /// What's still missing, in plain words; empty when the password is valid.
  static List<String> missing(String p, String confirm) => [
        if (!hasUppercase(p)) 'an uppercase letter',
        if (!hasLowercase(p)) 'a lowercase letter',
        if (!hasNumber(p)) 'a number',
        if (!hasSymbol(p)) 'a symbol (e.g. @#\$)',
        if (!hasValidLength(p)) '$minLength-$maxLength characters',
        if (!matches(p, confirm)) 'both passwords to match',
      ];

  static bool isValid(String p, String confirm) => missing(p, confirm).isEmpty;

  static String errorMessage(String p, String confirm) =>
      'Your password needs ${missing(p, confirm).join(', ')}.';
}

/// The "Include the following / Must contain" panels shown under the
/// password field.
class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: _Panel(
                title: 'Include the following',
                children: [
                  _Rule('ABC', PasswordRules.hasUppercase(password)),
                  _Rule('abc', PasswordRules.hasLowercase(password)),
                  _Rule('123', PasswordRules.hasNumber(password)),
                  _Rule('@#\$', PasswordRules.hasSymbol(password)),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 4,
              child: _Panel(
                title: 'Must contain',
                children: [
                  _Rule(
                    '${PasswordRules.minLength}-${PasswordRules.maxLength} '
                    'Chars',
                    PasswordRules.hasValidLength(password),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Passwords Match" shown under the confirm-password field.
class PasswordsMatchIndicator extends StatelessWidget {
  const PasswordsMatchIndicator({
    super.key,
    required this.password,
    required this.confirmPassword,
  });

  final String password;
  final String confirmPassword;

  @override
  Widget build(BuildContext context) {
    final met = PasswordRules.matches(password, confirmPassword);
    final color = met ? Theme.of(context).colorScheme.primary : Colors.grey;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 2),
      child: Row(
        children: [
          _CheckIcon(met: met),
          const SizedBox(width: 6),
          Text(
            met ? 'Passwords Match' : 'Passwords must match',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      color: Theme.of(context).colorScheme.primary.withOpacity(.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.5,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 10, runSpacing: 6, children: children),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule(this.label, this.met);

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CheckIcon(met: met),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.5,
                color: met ? Colors.black87 : Colors.grey.shade600,
              ),
        ),
      ],
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon({required this.met});

  final bool met;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Icon(
      met ? Icons.check_circle : Icons.radio_button_unchecked,
      size: 16,
      color: met ? primary : Colors.grey.shade400,
    );
  }
}
