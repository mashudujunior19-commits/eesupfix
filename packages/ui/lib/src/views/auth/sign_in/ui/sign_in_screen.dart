import 'package:auto_route/auto_route.dart';
import 'package:data/auth/data_source/abstract_auth_data_source.dart'
    show SocialProvider;
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/localize_south_african_phone.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:ui/src/views/auth/landing/van_scene.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';

/// Sign-in page: a green branded header, then a rounded white sheet with a
/// single email-or-phone field, the password, a gradient Log In button and
/// Google / Apple sign-in.
@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _identifier = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    // A Google / Apple login that isn't linked to a registered account is
    // turned away before this page is shown again; tell the user why.
    final notice = AuthRepository.signInNotice;
    if (notice != null) {
      AuthRepository.signInNotice = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.snackBarError(notice);
      });
    }
  }

  @override
  void dispose() {
    // Clear sensitive data on dispose
    _password = '';
    super.dispose();
  }

  void _handleSignIn() {
    FocusScope.of(context).unfocus();

    final id = _identifier.trim();
    if (id.isEmpty) {
      context.snackBarError('Enter an email or phone number');
      return;
    }

    String? email;
    String? phone;
    if (id.contains('@')) {
      if (!EmailValidator.validate(id)) {
        context.snackBarError('Enter a valid email address');
        return;
      }
      email = id;
    } else {
      phone = localizeSAPhoneNumber(id);
      if (phone == null) {
        context.snackBarError('Enter a valid South African phone number');
        return;
      }
    }

    if (_password.isEmpty) {
      context.snackBarError('Enter your password');
      return;
    }

    context.read<AuthBloc>().add(SignInPressed(email, phone, _password));
  }

  @override
  Widget build(BuildContext context) {
    return EESUpScaffold(
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
            if (context.router.current.name == SignInRoute.name) {
              context.router.replaceAll([const OverviewRoute()]);
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _Header(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                        child: _Form(
                          onIdentifierChanged: (v) => _identifier = v,
                          onPasswordChanged: (v) => _password = v,
                          onSubmit: _handleSignIn,
                        ),
                      ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    // Scales with the screen so it fits small and large phones, with notches.
    final height = (size.height * .29).clamp(210.0, 300.0);
    final vanWidth = (size.width * .5).clamp(150.0, 240.0);
    final titleSize = (size.width * .105).clamp(34.0, 52.0);
    return Container(
      height: height + MediaQuery.paddingOf(context).top,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [TowrisBrand.deepGreen, TowrisBrand.green, TowrisBrand.lightGreen],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Soft decorative shape behind the illustration.
            Positioned(
              right: -40,
              bottom: -30,
              child: Container(
                width: vanWidth * 1.1,
                height: vanWidth * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.08),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              top: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TowrisBrand.name,
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                      height: 1,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 300.ms).slideY(begin: .2, end: 0),
                  const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TowrisBrand.slogan,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: Colors.white.withOpacity(.95),
                      ),
                    ),
                  ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 22,
              width: vanWidth,
              height: vanWidth * .5,
              child: const VanIllustration(wheelTurn: .6)
                  .animate()
                  .slideX(begin: .4, end: 0, duration: 500.ms, curve: Curves.easeOutCubic)
                  .fadeIn(duration: 350.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.onIdentifierChanged,
    required this.onPasswordChanged,
    required this.onSubmit,
  });

  final ValueChanged<String> onIdentifierChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome Back',
          style: textTheme.displayMedium?.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1F1C),
          ),
        ).animate().slideIn(0),
        const SizedBox(height: 22),
        _PillField(
          key: const Key('identifier_text_field'),
          hint: 'Email or phone',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: onIdentifierChanged,
        ).animate().slideIn(60),
        const SizedBox(height: 14),
        _PillField(
          key: const Key('password_text_field'),
          hint: 'Password',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          textInputAction: TextInputAction.done,
          onChanged: onPasswordChanged,
          onSubmitted: (_) => onSubmit(),
        ).animate().slideIn(120),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            key: const Key('forgot_password_button'),
            onPressed: () => context.router.push(const ResetPasswordRoute()),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: TowrisBrand.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ).animate().slideIn(150),
        const SizedBox(height: 4),
        _GradientButton(
          key: const Key('sign_in_button'),
          label: 'Log In',
          onPressed: onSubmit,
        ).animate().slideIn(180),
        const SizedBox(height: 24),
        const _OrDivider().animate().slideIn(210),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                label: 'Google',
                asset: 'assets/images/google.png',
                onPressed: () => context
                    .read<AuthBloc>()
                    .add(SocialSignInPressed(SocialProvider.google)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _SocialButton(
                label: 'Apple',
                asset: 'assets/images/apple-logo.png',
                onPressed: () => context
                    .read<AuthBloc>()
                    .add(SocialSignInPressed(SocialProvider.apple)),
              ),
            ),
          ],
        ).animate().slideIn(240),
        const SizedBox(height: 10),
        Text(
          'Google and Apple sign-in is for existing Towris accounts only.',
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ).animate().slideIn(255),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () => context.router.push(const RegisterRoute()),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: TowrisBrand.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ).animate().slideIn(270),
      ],
    );
  }
}

class _PillField extends StatefulWidget {
  const _PillField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<_PillField> createState() => _PillFieldState();
}

class _PillFieldState extends State<_PillField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color c, double w) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: c, width: w),
        );
    return TextField(
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: false,
      enableSuggestions: !widget.isPassword,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
        filled: true,
        fillColor: const Color(0xFFF2F1EB),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        prefixIcon: Icon(widget.icon, color: Colors.grey.shade700),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade600,
                ),
              )
            : null,
        border: border(Colors.transparent, 0),
        enabledBorder: border(Colors.transparent, 0),
        focusedBorder: border(TowrisBrand.lightGreen, 1.6),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [TowrisBrand.deepGreen, TowrisBrand.green, TowrisBrand.lightGreen],
          ),
          boxShadow: [
            BoxShadow(
              color: TowrisBrand.green.withOpacity(.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Divider(color: Colors.grey.shade300, thickness: 1),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Or continue with',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ),
        line,
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.asset,
    required this.onPressed,
  });

  final String label;
  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Sign in with $label',
      child: Material(
        color: const Color(0xFFF2F1EB),
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onPressed,
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(asset, width: 24, height: 24),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1F1C),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
