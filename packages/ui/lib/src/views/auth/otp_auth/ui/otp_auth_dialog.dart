// ignore_for_file: use_build_context_synchronously

import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

class OtpAuthDialog extends StatefulWidget {
  const OtpAuthDialog({
    super.key,
    this.email,
    this.phone,
    this.isSignUp = false,
    required this.type,
  });
  final String? email;
  final String? phone;
  final bool isSignUp;
  final OtpType type;

  @override
  State<OtpAuthDialog> createState() => _OtpAuthDialogState();
}

class _OtpAuthDialogState extends State<OtpAuthDialog> {
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
          if (widget.phone != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your phone number, +${widget.phone}',
                textAlign: TextAlign.center,
              ),
            ),
          if (widget.email != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your email address, ${widget.email}',
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
              onPressed: () async {
                FocusScope.of(context).unfocus();

                OtpType type = widget.type;

                if (widget.isSignUp) {
                  if (widget.phone != null) {
                    type = OtpType.sms;
                  } else if (widget.email != null) {
                    type = OtpType.signup;
                  }
                }

                context.loaderOverlay.show();
                final res = await context.read<AuthRepository>().verifyOtp(
                      email: widget.email,
                      phone: widget.phone,
                      otp: controller.text,
                      type: type,
                    );
                context.loaderOverlay.hide();

                if (res) {
                  Navigator.pop(context, true);
                } else {
                  context.snackBarError('Invalid or expired OTP');
                }
              },
              child: const Text('Verify'),
            ),
          ),
          10.sH,
          TextButton(
            onPressed: () async {
              OtpType type = widget.type;

              if (widget.isSignUp) {
                if (widget.phone != null) {
                  type = OtpType.sms;
                } else if (widget.email != null) {
                  type = OtpType.signup;
                }
              }

              context.loaderOverlay.show();
              final res = await context.read<AuthRepository>().resendOtp(
                    email: widget.email,
                    phone: widget.phone,
                    type: type,
                  );
              context.loaderOverlay.hide();

              res.fold((left) {
                context.snackBarError(left.message);
              }, (right) {
                if (right) {
                  context.snackBarSuccess('OTP resent');
                } else {
                  context.snackBarError('Failed to resend OTP');
                }
              });
            },
            child: const Text('Resend'),
          ),
        ],
      ),
    );
  }
}
