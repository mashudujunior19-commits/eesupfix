import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:ui/src/views/auth/otp_auth/ui/otp_auth_dialog.dart';
import 'package:ui/src/views/auth/register/cubit/register_cubit.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';
import 'package:ui/src/views/auth/register/ui/corporate_form.dart';
import 'package:ui/src/views/auth/register/ui/credentials_form.dart';
import 'package:ui/src/views/auth/register/ui/individual_form.dart';
import 'package:ui/src/views/auth/register/ui/referral_code_form.dart';
import 'package:ui/src/views/auth/register/ui/select_account_type.dart';
import 'package:ui/src/views/auth/register/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:ui/src/views/auth/sign_in/ui/background_decoration.dart';

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.router.pushAll([const OverviewRoute()]);
        }
      },
      child: BlocProvider(
        create: (context) => RegisterCubit(context.read<AuthRepository>()),
        child: BlocConsumer<RegisterCubit, RegisterForm>(
          builder: (context, state) {
            return SizedBox(
              child: EESUpScaffold(
                body: BackgroundDecoration(
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
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
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
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, RegisterForm state) {
            if (state.isLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state.status == RegisterStatus.failed) {
              context.snackBarError(state.errorMessage?.toString() ?? "");
            }

            if (state.status == RegisterStatus.awaitingOtp) {
              context
                  .showBottomSheetDialog(
                child: OtpAuthDialog(
                  type: OtpType.signup,
                  email: state.email,
                  phone: state.phone,
                  isSignUp: true,
                ),
              )
                  .then((value) {
                if (!mounted) return;
                // value == true: OTP verified successfully
                // value == false: OTP verification failed
                // value == null: Dialog dismissed without action
                if (value == true) {
                  _tabController.animateTo(_tabController.index + 1);
                } else if (value == false) {
                  context.snackBarError('OTP verification failed');
                }
                // null = dismissed, don't show error
              });
            }
          },
        ),
      ),
    );
  }
}
