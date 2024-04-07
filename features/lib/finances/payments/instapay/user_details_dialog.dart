import 'package:data_sources/auth/models/profile.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:repository/utils/localize_south_african_phone.dart';

class UserDetailsDialog extends StatefulWidget {
  const UserDetailsDialog({super.key, required this.prfile});
  final Profile? prfile;

  @override
  State<UserDetailsDialog> createState() => UserDetailsDialogState();
}

class UserDetailsDialogState extends State<UserDetailsDialog> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  String phoneNum = '';

  @override
  void initState() {
    super.initState();

    fNameController.text = widget.prfile?.firstName ?? '';
    lNameController.text = widget.prfile?.lastName ?? '';
    emailController.text = widget.prfile?.email ?? '';
    final phone = formatPhone(widget.prfile?.phone);
    phoneNum = phone;
  }

  String formatPhone(String? phone) {
    if (phone == null) {
      return '';
    }
    final local = localizeSAPhoneNumber(phone);
    return local != null ? '+$local' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(''),
        actions: [
          SizedBox(
            width: 150,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () {
                if (fNameController.text.isEmpty) {
                  context.snackBarError("Your first name is required");
                  return;
                }

                if (lNameController.text.isEmpty) {
                  context.snackBarError("Your last name is required");
                  return;
                }

                if (emailController.text.isEmpty) {
                  context.snackBarError("Your email is required");
                  return;
                }

                if (phoneNum.isEmpty) {
                  context.snackBarError("Your phone number is required");
                  return;
                }

                Navigator.pop(
                  context,
                  widget.prfile?.copyWith(
                    firstName: fNameController.text,
                    lastName: lNameController.text,
                    email: emailController.text,
                    phone: phoneNum,
                  ),
                );
              },
              child: const Text('Pay now'),
            ),
          ),
          20.sW,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 500,
          top: 20,
        ),
        children: [
          const Text(
            'Please provide the missing information',
            textAlign: TextAlign.start,
          ),
          15.sH,
          EESUpTextFormField(
            controller: fNameController,
            label: 'First name',
          ),
          EESUpTextFormField(
            controller: lNameController,
            label: 'Last name',
          ),
          EESUpTextFormField(
            controller: emailController,
            label: 'Email',
          ),
          15.sH,
          const Text('Phone'),
          5.sH,
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15)),
            child: PhoneTextField(
              initialCountry: countries.firstWhere((e) => e.code == 'ZA'),
              initialValue: phoneNum,
              decoration: const InputDecoration(border: InputBorder.none),
              onChanged: (value) {
                phoneNum = formatPhone(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
