import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/features/auth/otp_auth/ui/otp_auth_dialog.dart';
import 'package:ui/src/features/auth/register/ui/email_and_phone_tab_container.dart';

// ignore: must_be_immutable
class CredentialsFormTab extends StatefulWidget {
  const CredentialsFormTab({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<CredentialsFormTab> createState() => _CredentialsFormTabState();
}

class _CredentialsFormTabState extends State<CredentialsFormTab> {
  String? email;
  String? phone;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 400),
      children: [
        Container(
          width: context.width,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          color: Colors.white,
          child: Text(
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
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              EmailAndPhoneTabContainer(
                onEmailChanged: (e) {
                  email = e;
                  phone = null;
                },
                onPhoneChanged: (p) {
                  email = null;
                  phone = p;
                  print(phone);
                },
              ),
              25.sH,
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  print(phone);
                  print(email);

                  if (email != null) {
                    final res = await context
                        .read<AuthRepository>()
                        .resetPasswordWithEmail(email!);

                    res.fold((left) {
                      context.snackBarError(left.message);
                    }, (right) {
                      if (right) {
                        context
                            .showBottomSheetDialog(
                          child: OtpAuthDialog(
                            type: OtpType.recovery,
                            email: email,
                            phone: null,
                            isSignUp: false,
                          ),
                        )
                            .then((value) {
                          ///THIS RETURNS TRUE IF OTP AUTH IS SUCCESS
                          if (value == true) {
                            widget.tabController
                                .animateTo(widget.tabController.index++);
                          } else {
                            ///ELSE IT IS RESTARTED
                            context.snackBarError('Otp verification failed');
                          }
                        });
                      }
                    });
                  } else if (phone != null) {
                    final res = await context
                        .read<AuthRepository>()
                        .resetPasswordWithPhone(phone!);
                    res.fold((left) {
                      context.snackBarError(left.message);
                    }, (right) {
                      if (right) {
                        context
                            .showBottomSheetDialog(
                          child: OtpAuthDialog(
                            type: OtpType.recovery,
                            email: email,
                            phone: null,
                            isSignUp: false,
                          ),
                        )
                            .then((value) {
                          ///THIS RETURNS TRUE IF OTP AUTH IS SUCCESS
                          if (value == true) {
                            widget.tabController
                                .animateTo(widget.tabController.index++);
                          } else {
                            ///ELSE IT IS RESTARTED
                            context.snackBarError('Otp verification failed');
                          }
                        });
                      }
                    });
                  } else {
                    context
                        .snackBarError('Enter a valid email or phone number');
                    return;
                  }
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
