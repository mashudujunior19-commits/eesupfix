// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PasswordStrength extends StatelessWidget {
  PasswordStrength({
    super.key,
    required this.password,
    required this.confirmPassword,
    required this.onValidPassword,
  });
  final String password;
  final String confirmPassword;
  final Function(bool) onValidPassword;

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecial = false;
  bool hasLength = false;
  bool passwordMatch = false;

  void checkPassword() {
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasLowercase = password.contains(RegExp(r'[a-z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasSpecial = password.contains(RegExp(r'[!@#$%^&*()]'));
    if (password == confirmPassword &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      passwordMatch = true;
    } else {
      passwordMatch = false;
    }
    if (password.length >= 8) {
      hasLength = true;
    } else {
      hasLength = false;
    }
    onValidPassword(checkPasswordValid());
  }

  //check if password is valid
  bool checkPasswordValid() {
    if (hasUppercase &&
        hasLowercase &&
        hasNumber &&
        hasSpecial &&
        hasLength &&
        passwordMatch) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkPassword();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        children: [
          _Requirment(isMet: hasUppercase, label: 'Uppercase'),
          _Requirment(isMet: hasLowercase, label: 'Lowercase'),
          _Requirment(isMet: hasNumber, label: 'Number'),
          _Requirment(isMet: hasSpecial, label: 'Special'),
          _Requirment(isMet: hasLength, label: '8 Characters'),
          _Requirment(isMet: passwordMatch, label: 'Match'),
        ],
      ),
    );
  }
}

class _Requirment extends StatelessWidget {
  const _Requirment({
    required this.isMet,
    required this.label,
  });

  final bool isMet;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    final color1 = theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: isMet ? color1 : Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: textTheme?.copyWith(
              fontSize: 12,
              color: isMet ? color1 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
