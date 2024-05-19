import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/features/auth/otp_auth/ui/otp_auth_dialog.dart';
import 'package:ui/src/features/auth/register/bloc/registration_bloc.dart';
import 'package:ui/src/features/auth/register/ui/corporate_form.dart';
import 'package:ui/src/features/auth/register/ui/credentials_form.dart';
import 'package:ui/src/features/auth/register/ui/individual_form.dart';
import 'package:ui/src/features/auth/register/ui/referral_code_form.dart';
import 'package:ui/src/features/auth/register/ui/select_account_type.dart';
import 'package:ui/src/features/auth/register/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(context.read<AuthRepository>()),
      child: BlocConsumer<RegistrationBloc, RegistrationFormState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state is FailedToSignUp) {
            context.snackBarError(state.err.message);
            context.read<RegistrationBloc>().add(
                  SignUpRestarted(state.oldForm),
                );
          }

          if (state is AwaitingOtpAuth) {
            context
                .showBottomSheetDialog(
              child: OtpAuthDialog(
                type: OtpType.signup,
                email: state.oldForm.email,
                phone: state.oldForm.phone,
                isSignUp: true,
              ),
            )
                .then((value) {
              ///THIS RETURNS TRUE IF OTP AUTH IS SUCCESS
              if (value == true) {
                _tabController.animateTo(_tabController.index++);
              } else {
                ///ELSE IT IS RESTARTED
                context.snackBarError('Otp verification failed');

                context
                    .read<RegistrationBloc>()
                    .add(SignUpRestarted(state.oldForm));
              }
            });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                decoration: context.bgImage,
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: _bg(),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      //Hide Back button on the welcome tab
                      leading: _tabController.index != 4
                          ? BackButton(onPressed: () {
                              if (_tabController.index == 0) {
                                Navigator.of(context).pop();
                              } else {
                                _tabController
                                    .animateTo(_tabController.index - 1);
                              }
                            })
                          : null,
                      title: _tabController.index != 4
                          ? const Text('Sign up')
                          : null,
                    ),
                    body: () {
                      if (state is SignUpForm) {
                        return TabBarView(
                          // physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            SelectAccountType(tabController: _tabController),
                            if (state.isCorp)
                              CorporateForm(
                                tabController: _tabController,
                                form: state,
                              )
                            else
                              IndividualForm(
                                tabController: _tabController,
                                form: state,
                              ),
                            CredentialsForm(
                              form: state,
                              tabController: _tabController,
                            ),
                            ReferralCodeForm(
                              tabController: _tabController,
                              form: state,
                            ),
                            const WelcomeScreen(),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _bg() {
    return BoxDecoration(
      color: Colors.white.withOpacity(.67),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(.2),
          blurRadius: 30,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
