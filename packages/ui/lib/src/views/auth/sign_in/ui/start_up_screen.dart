import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/auth/landing/van_scene.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';

/// The auto-playing landing sequence:
///
/// 1. A Towris van drives across town carrying groceries while neighbours wave;
///    the name and slogan sit above the scene.
/// 2. The scene fades into the centred logo.
/// 3. The logo is held for exactly [logoHold], then the user is sent on to the
///    sign-in page (or straight into the app if they are already signed in).
@RoutePage()
class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  /// How long the finished logo stays on screen before redirecting.
  static const Duration logoHold = Duration(seconds: 2);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen>
    with TickerProviderStateMixin {
  late final AuthBloc _authBloc;
  late final AnimationController _scene;
  late final AnimationController _logo;
  Timer? _holdTimer;

  AuthBlocState? _authState;
  bool _holdFinished = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(context.read<AuthRepository>())..add(AppStarted());

    _scene = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5400),
    );
    _logo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scene.forward().whenComplete(() {
      if (!mounted) return;
      _logo.forward().whenComplete(() {
        if (!mounted) return;
        // The logo is fully visible now: hold it for exactly two seconds.
        _holdTimer = Timer(StartUpScreen.logoHold, () {
          _holdFinished = true;
          _tryNavigate();
        });
      });
    });
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _scene.dispose();
    _logo.dispose();
    _authBloc.close();
    super.dispose();
  }

  /// Redirects once the logo hold is over and the sign-in state is known.
  void _tryNavigate() {
    if (_navigated || !_holdFinished || !mounted) return;
    final state = _authState;
    if (state == null) return;

    if (state is Authenticated) {
      _navigated = true;
      context.router.replaceAll([const OverviewRoute()]);
    } else if (state is PasswordResetPending) {
      _navigated = true;
      context.router.replaceAll([
        ResumePasswordResetRoute(email: state.email, phone: state.phone),
      ]);
    } else if (state is UnAuthenticated) {
      _navigated = true;
      context.router.replaceAll([const SignInRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      bloc: _authBloc,
      listener: (context, state) {
        _authState = state;
        _tryNavigate();
      },
      child: Scaffold(
        key: const Key('start_up_screen'),
        backgroundColor: Colors.white,
        body: AnimatedBuilder(
          animation: Listenable.merge([_scene, _logo]),
          builder: (context, _) {
            final logoT = Curves.easeOutCubic.transform(_logo.value);
            return Stack(
              fit: StackFit.expand,
              children: [
                Opacity(
                  opacity: 1 - logoT,
                  child: _SceneLayer(t: _scene.value),
                ),
                if (_logo.value > 0)
                  Center(
                    child: Opacity(
                      opacity: logoT,
                      child: Transform.scale(
                        scale: .88 + .12 * logoT,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * .55,
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SceneLayer extends StatelessWidget {
  const _SceneLayer({required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Title and slogan ease in during the first moments of the scene.
    final intro = Curves.easeOutCubic.transform((t / .14).clamp(0.0, 1.0));
    final sloganIn = Curves.easeOutCubic.transform(((t - .06) / .14).clamp(0.0, 1.0));

    return Stack(
      fit: StackFit.expand,
      children: [
        VanScene(progress: t),
        SafeArea(
          child: Align(
            alignment: const Alignment(0, -.62),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: intro,
                  child: Transform.translate(
                    offset: Offset(0, 14 * (1 - intro)),
                    child: Text(
                      TowrisBrand.name,
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                        height: 1,
                        color: TowrisBrand.deepGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Opacity(
                  opacity: sloganIn,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - sloganIn)),
                    child: Text(
                      TowrisBrand.slogan.toUpperCase(),
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.2,
                        color: TowrisBrand.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
