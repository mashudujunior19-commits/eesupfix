import 'package:auto_route/auto_route.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:ui/src/views/auth/register/ui/email_and_phone_tab_container.dart';
import 'package:ui/src/views/auth/sign_in/ui/background_decoration.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

String? _phone = '';
String? _email = '';
String _password = '';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('sign_in_screen'),
      child: EESUpScaffold(
        body: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is AuthError) {
              context.snackBarError(state.error.message);
            }

            if (state is Authenticated) {
              context.router.replaceAll([const OverviewRoute()]);
            }
          },
          child: BlocBuilder<AuthBloc, AuthBlocState>(
            builder: (context, state) {
              return BackgroundDecoration(
                key: const Key('background_decoration'),
                child: Center(
                  child: ListView(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 100,
                      bottom: 100,
                    ),
                    children: [
                      const _WelcomeMessage(),
                      20.sH,
                      EmailAndPhoneTabContainer(
                        onEmailChanged: (e) {
                          _email = e?.trim();
                          _phone = null;
                        },
                        onPhoneChanged: (p) {
                          _phone = p?.trim();
                          _email = null;
                        },
                      ).animate().slideIn(100),
                      EESUpTextFormField(
                        key: const Key('password_text_field'),
                        onChanged: (password) {
                          _password = password;
                        },
                        isPassword: true,
                        label: 'Password',
                      ).animate().slideIn(150),
                      20.sH,
                      const _ForgotPasswordButton(
                        key: Key('forgot_password_button'),
                      ).animate().slideIn(150),
                      ElevatedButton(
                        key: const Key('sign_in_button'),
                        child: const Text('Sign In'),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_email == null && _phone == null) {
                            context.snackBarError(
                                'Enter an email or phone number');
                            return;
                          }

                          if (_password.isEmpty) {
                            context.snackBarError('Enter your password');
                            return;
                          }

                          context
                              .read<AuthBloc>()
                              .add(SignInPressed(_email, _phone, _password));
                        },
                      ).animate().slideIn(200),
                      20.sH,
                      HighlightedText(
                        'Don\'t  have an account?  Register',
                        patterns: const ['Register'],
                        style: context.textTheme.displayMedium!.copyWith(
                          color: Colors.grey.shade800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        dotAll: true,
                        highLightStyle:
                            context.textTheme.displayMedium!.copyWith(
                          color: context.colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        onTap: (p) {
                          context.router.push(const RegisterRoute());
                        },
                      ).animate().slideIn(250)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          key: key,
          onPressed: () {
            context.router.push(const ResetPasswordRoute());
          },
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
          child: Image.asset(
            'assets/images/logo.png',
            alignment: Alignment.center,
          ),
        ).animate().slideIn(0),
        15.sH,
        Text(
          'Welcome back!',
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium,
        ).animate().slideIn(50),
      ],
    );
  }
}
