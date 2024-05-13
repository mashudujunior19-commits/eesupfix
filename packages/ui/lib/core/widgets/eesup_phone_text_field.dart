import 'package:data/utils/localize_south_african_phone.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';

// ignore: must_be_immutable
class EESUpPhoneTextField extends StatelessWidget {
  EESUpPhoneTextField({super.key, this.onChanged});
  final void Function(String? phone)? onChanged;
  String? phone = '';

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
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: PhoneTextField(
            key: const Key('phone_text_field'),
            initialCountry: countries.firstWhere((e) => e.code == 'ZA'),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (p) {
              phone = localizeSAPhoneNumber(p);
              onChanged?.call(phone);
            },
          ),
        ),
      ],
    );
  }
}
