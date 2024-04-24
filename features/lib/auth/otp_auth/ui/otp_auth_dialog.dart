import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpAuthDialog extends StatelessWidget {
  OtpAuthDialog({
    super.key,
    this.email,
    this.phone,
    required this.type,
  });
  final String? email;
  final String? phone;
  final OtpType type;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Verify One time pin'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/verification_person.png',
            ),
          ),
          if (phone != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your phone number, +$phone',
                textAlign: TextAlign.center,
              ),
            ),
          if (email != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your email address, $email',
                textAlign: TextAlign.center,
              ),
            ),
          EESUpTextFormField(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 15),
            hintText: 'Enter One-Time-Pin',
            controller: controller,
            type: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Verify'),
            ),
          )
        ],
      ),
    );
  }
}
