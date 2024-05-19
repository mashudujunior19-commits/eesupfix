import 'package:data/utils/localize_south_african_phone.dart';
import 'package:flutter/material.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:tab_container/tab_container.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

class EmailAndPhoneTabContainer extends StatefulWidget {
  const EmailAndPhoneTabContainer({
    super.key,
    this.initEmail,
    this.initPhone,
    required this.onEmailChanged,
    required this.onPhoneChanged,
  });
  final String? initEmail;
  final String? initPhone;
  final void Function(String? email) onEmailChanged;
  final void Function(String? phone) onPhoneChanged;

  @override
  State<EmailAndPhoneTabContainer> createState() =>
      _EmailAndPhoneTabContainerState();
}

class _EmailAndPhoneTabContainerState extends State<EmailAndPhoneTabContainer>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: TabContainer(
        controller: _controller,
        childPadding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.white,
        tabBorderRadius: BorderRadius.circular(15),
        tabs: const [Text('Email'), Text('Phone')],
        children: [
          EESUpTextFormField(
            margin: const EdgeInsets.only(top: 0),
            hintText: 'email@gmail.com',
            initialValue: widget.initEmail,
            onChanged: (value) {
              final v = value.isEmpty ? null : value;
              widget.onEmailChanged(v);
              widget.onPhoneChanged(null);
            },
          ),
          Container(
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
              initialCountry: countries.firstWhere(
                (e) => e.code == 'ZA',
              ),
              textStyle: context.textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
              onChanged: (value) {
                final phone = localizeSAPhoneNumber(value);
                widget.onPhoneChanged(phone);
                widget.onEmailChanged(null);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          )
        ],
      ),
    );
  }
}
