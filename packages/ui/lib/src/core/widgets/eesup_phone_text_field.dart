import 'package:data/utils/localize_south_african_phone.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';

/// A South African phone number field.
///
/// [onChanged] receives the number in `27XXXXXXXXX` form once it's a valid
/// SA number, null when the field is cleared, and otherwise the digits as
/// typed, so a half-typed number is never mistaken for "no phone number".
/// Use [isValidPhone] to check a value before saving it.
class EESUpPhoneTextField extends StatefulWidget {
  const EESUpPhoneTextField({super.key, this.onChanged, this.initialValue});

  final void Function(String? phone)? onChanged;

  /// A stored number (e.g. `27821234567`), shown in local `0821234567` form.
  final String? initialValue;

  static bool isValidPhone(String? phone) =>
      phone == null || localizeSAPhoneNumber(phone) == phone;

  @override
  State<EESUpPhoneTextField> createState() => _EESUpPhoneTextFieldState();
}

class _EESUpPhoneTextFieldState extends State<EESUpPhoneTextField> {
  String? _error;

  String? get _initialLocal {
    final stored = widget.initialValue;
    if (stored == null || stored.isEmpty) return null;
    return stored.startsWith('27') ? '0${stored.substring(2)}' : stored;
  }

  void _onChanged(String value) {
    // The field prefixes the dial code (+27); drop everything that isn't a
    // digit so spaces/dashes from a pasted number don't make it invalid.
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final typed = digits.length <= 2 ? '' : digits;
    final localized = localizeSAPhoneNumber(typed);
    setState(() {
      _error = typed.isEmpty || localized != null
          ? null
          : 'Enter a valid South African number';
    });
    widget.onChanged?.call(typed.isEmpty ? null : localized ?? typed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        10.sH,
        Text(
          'Phone',
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withOpacity(.03),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _error == null
                  ? Colors.grey.shade300
                  : context.colorScheme.error,
              width: .5,
            ),
          ),
          child: PhoneTextField(
            key: const Key('phone_text_field'),
            initialValue: _initialLocal,
            initialCountry: countries.firstWhere((e) => e.code == 'ZA'),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: _onChanged,
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              _error!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
