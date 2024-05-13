import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:ui/core/widgets/eesup_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class CredentialsFormTab extends StatefulWidget {
  const CredentialsFormTab({super.key});

  @override
  State<CredentialsFormTab> createState() => _CredentialsFormTabState();
}

class _CredentialsFormTabState extends State<CredentialsFormTab> {
  final _tabContainerController = TabContainerController(length: 2);

  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabContainerController.addListener(() {
      setState(() {
        index = _tabContainerController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 50,
        bottom: 400,
      ),
      children: [
        Text(
          'Don\'t worry! it happens to the best of us.'
          ' Please enter an email address or mobile number '
          'associated with your account and we will send'
          ' you an One-Time-Pin to reset your password.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.5,
            color: Colors.grey,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          height: index == 0 ? 170 : 210,
          child: TabContainer(
            controller: _tabContainerController,
            childPadding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
            ),
            color: Colors.grey.shade100,
            radius: 15,
            tabs: const [
              'Email',
              'Phone',
            ],
            children: [
              EESUpTextFormField(
                margin: const EdgeInsets.only(top: 0),
                hintText: 'email@gmail.com',
                label: 'Email',
              ),
              EESUpPhoneTextField(
                onChanged: (p) {},
              )
            ],
          ),
        ),
        25.sH,
        ElevatedButton(onPressed: () {}, child: const Text('Reset'))
      ],
    );
  }
}
