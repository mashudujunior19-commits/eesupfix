import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/auth/sign_in/bloc/auth_bloc.dart';
import 'package:repository/utils/localize_south_african_phone.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tab_container/tab_container.dart';
import 'widgets/background_decoration.dart';

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
      child: Scaffold(
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
                      const _SignInForm(key: Key('sign_in_form')),
                      20.sH,
                      const _ForgotPasswordButton(
                        key: Key('forgot_password_button'),
                      ).animate().slideIn(150),
                      ElevatedButton(
                        key: const Key('sign_in_button'),
                        child: const Text('Sign In'),
                        onPressed: () {
                          if (_email == null && _phone == null) {
                            context.snackBarError(
                              'Please enter either email or phone number',
                            );
                            return;
                          }

                          if (_password.isEmpty) {
                            context.snackBarError('Please enter your password');
                            return;
                          }

                          context.read<AuthBloc>().add(
                                SignInPressed(_email, _phone, _password),
                              );
                        },
                      ).animate().slideIn(200),
                      20.sH,
                      const _RegisterButton(key: Key('register_button'))
                          .animate()
                          .slideIn(250)
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: key,
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: context.textTheme.displayMedium!.copyWith(
          color: Colors.grey.shade800,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: 'Register',
            style: context.textTheme.displayMedium?.copyWith(
              color: context.colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.router.push(const RegisterRoute());
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          height: 140,
          child: TabContainer(
            childPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            onEnd: () {
              FocusScope.of(context).unfocus();
              _email = null;
              _phone = null;
            },
            color: Colors.white.withOpacity(.5),
            controller: TabContainerController(length: 2),
            radius: 15,
            tabs: const ['Email', 'Phone'],
            children: [
              EESUpTextFormField(
                key: const Key('email_text_field'),
                onChanged: (email) {
                  _email = email;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
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
                  onChanged: (phone) {
                    _phone = localizeSAPhoneNumber(phone);
                  },
                ),
              ),
            ],
          ),
        ).animate().slideIn(100),
        EESUpTextFormField(
          key: const Key('password_text_field'),
          onChanged: (password) {
            _password = password;
          },
          isPassword: true,
          label: 'Password',
        ).animate().slideIn(150),
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
