import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/auth/intro/intro_seen.dart';
import 'package:ui/src/views/auth/landing/photo_scene.dart';
import 'package:ui/src/views/auth/landing/van_scene.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';
import 'package:video_player/video_player.dart';

/// The auto-playing landing sequence:
///
/// 1. The Towris landing video plays (`assets/videos/landing.mp4`, silent,
///    about 3.5 seconds). If it cannot play, the older animated scene is
///    shown instead (a loaded truck driving past, ~[sceneDuration]).
/// 2. Either one fades ([logoFade]) into the green brand screen with the
///    white logo.
/// 3. That screen is held for [logoHold], then the user is sent on: into the
///    app if signed in, otherwise to the intro pages (first time on the
///    device) or the sign-in page.
@RoutePage()
class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  static const Duration sceneDuration = Duration(milliseconds: 3000);
  static const Duration logoFade = Duration(milliseconds: 280);

  static const String videoAsset = 'assets/videos/landing.mp4';

  /// If the video has not started by then, the animated scene is used.
  static const Duration videoStartTimeout = Duration(seconds: 4);

  /// A short beat on the brand screen before redirecting.
  static const Duration logoHold = Duration(milliseconds: 1400);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen>
    with TickerProviderStateMixin {
  late final AuthBloc _authBloc;
  late final AnimationController _scene;
  late final AnimationController _logo;
  Timer? _holdTimer;
  Timer? _videoGuard;
  LandingPhotos _photos = LandingPhotos.none;
  VideoPlayerController? _video;
  bool _videoReady = false;
  bool _videoEnded = false;
  bool _fallbackStarted = false;

  AuthBlocState? _authState;
  bool? _introSeen;
  bool _holdFinished = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(context.read<AuthRepository>())..add(AppStarted());

    _scene = AnimationController(
      vsync: this,
      duration: StartUpScreen.sceneDuration,
    );
    _logo = AnimationController(
      vsync: this,
      duration: StartUpScreen.logoFade,
    );

    // Load the logo while the video plays, so the brand screen at the end
    // shows it straight away (on the web it is fetched on first use).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(const AssetImage(_logoAsset), context);
      }
    });

    // Signed-out users see the intro pages before the sign-in page until
    // someone has signed in on the device.
    IntroSeen.get().then((seen) {
      _introSeen = seen;
      _tryNavigate();
    });

    _startVideo();
  }

  /// Plays the landing video. If it does not start within a few seconds, or
  /// fails, the animated scene takes over so the app never waits on it.
  Future<void> _startVideo() async {
    final controller = VideoPlayerController.asset(StartUpScreen.videoAsset);
    _video = controller;
    _videoGuard = Timer(StartUpScreen.videoStartTimeout, () {
      if (!_videoReady) _startFallbackScene();
    });
    try {
      await controller.initialize();
      if (!mounted || _fallbackStarted) return;
      await controller.setVolume(0);
      await controller.setLooping(false);
      controller.addListener(_onVideoTick);
      setState(() => _videoReady = true);
      await controller.play();
    } catch (e) {
      debugPrint('Landing video could not play: $e');
      _startFallbackScene();
    }
  }

  void _onVideoTick() {
    final v = _video?.value;
    if (v == null || _videoEnded || !v.isInitialized) return;
    if (v.duration > Duration.zero &&
        v.position >= v.duration - const Duration(milliseconds: 80)) {
      _videoEnded = true;
      _showBrand();
    }
  }

  void _startFallbackScene() {
    if (_fallbackStarted || _videoReady || !mounted) return;
    _fallbackStarted = true;
    setState(() {});
    // The photographs (if any) are picked up as soon as the asset list has
    // been read, which takes a few milliseconds.
    LandingPhotos.load().then((photos) {
      if (mounted) setState(() => _photos = photos);
    });
    _scene.forward().whenComplete(_showBrand);
  }

  /// Fades into the brand screen, holds it briefly, then moves on.
  void _showBrand() {
    if (!mounted || _logo.isAnimating || _logo.value > 0) return;
    _logo.forward().whenComplete(() {
      if (!mounted) return;
      _holdTimer = Timer(StartUpScreen.logoHold, () {
        _holdFinished = true;
        _tryNavigate();
      });
    });
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _videoGuard?.cancel();
    _video?.removeListener(_onVideoTick);
    _video?.dispose();
    _scene.dispose();
    _logo.dispose();
    _authBloc.close();
    super.dispose();
  }

  /// Redirects once the brand screen hold is over and the sign-in state is
  /// known.
  void _tryNavigate() {
    if (_navigated || !_holdFinished || !mounted) return;
    final state = _authState;
    if (state == null) return;

    if (state is Authenticated) {
      IntroSeen.markSeen();
      _navigated = true;
      context.router.replaceAll([const OverviewRoute()]);
    } else if (state is PasswordResetPending) {
      _navigated = true;
      context.router.replaceAll([
        ResumePasswordResetRoute(email: state.email, phone: state.phone),
      ]);
    } else if (state is UnAuthenticated) {
      final introSeen = _introSeen;
      if (introSeen == null) return; // still reading; called again when known
      _navigated = true;
      context.router.replaceAll([
        introSeen ? const SignInRoute() : const IntroRoute(),
      ]);
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
        backgroundColor: _fallbackStarted ? Colors.white : TowrisBrand.night,
        body: AnimatedBuilder(
          animation: Listenable.merge([_scene, _logo]),
          builder: (context, _) {
            final logoT = Curves.easeOutCubic.transform(_logo.value);
            final Widget opening;
            if (_videoReady) {
              opening = Center(
                child: AspectRatio(
                  aspectRatio: _video!.value.aspectRatio,
                  child: VideoPlayer(_video!),
                ),
              );
            } else if (_fallbackStarted) {
              opening = _SceneLayer(t: _scene.value, photos: _photos);
            } else {
              opening = const SizedBox.expand();
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                if (logoT < 1) Opacity(opacity: 1 - logoT, child: opening),
                if (_logo.value > 0)
                  Opacity(
                    opacity: logoT,
                    child: _BrandSplash(progress: logoT),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// The brand screen the animation settles on: a full Towris-green gradient,
/// the logo in white in the upper part and a short line at the bottom.
const _logoAsset = 'assets/images/logo.png';

class _BrandSplash extends StatelessWidget {
  const _BrandSplash({required this.progress});

  /// 0 -> 1 as the screen fades in.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoWidth = math.min(size.width * .52, size.height * .28);
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [TowrisBrand.deepGreen, TowrisBrand.green, Color(0xFF6DB54A)],
          stops: [0, .55, 1],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 3),
            Transform.translate(
              offset: Offset(0, 16 * (1 - progress)),
              child: Transform.scale(
                scale: .92 + .08 * progress,
                // The logo drawn in white, as on the example splash screens.
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    _logoAsset,
                    width: logoWidth,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => SizedBox(width: logoWidth),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              TowrisBrand.slogan,
              style: textTheme.titleSmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
                color: Colors.white.withOpacity(.9),
              ),
            ),
            const Spacer(flex: 7),
            Text(
              'Connecting towns and businesses',
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(.8),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _SceneLayer extends StatelessWidget {
  const _SceneLayer({required this.t, required this.photos});

  final double t;
  final LandingPhotos photos;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    // Type scales with the screen so it fits small and large phones alike.
    final titleSize = (size.shortestSide * .17).clamp(44.0, 84.0);
    final sloganSize = (size.shortestSide * .037).clamp(12.0, 20.0);
    final onPhoto = photos.available;
    final titleColor = onPhoto ? Colors.white : TowrisBrand.deepGreen;
    final sloganColor = onPhoto ? Colors.white : TowrisBrand.green;
    final shadows = onPhoto
        ? const [Shadow(color: Color(0x80000000), blurRadius: 12)]
        : null;

    // Title and slogan are on screen almost immediately.
    final intro = Curves.easeOutCubic.transform((t / .07).clamp(0.0, 1.0));
    final sloganIn =
        Curves.easeOutCubic.transform(((t - .03) / .08).clamp(0.0, 1.0));

    return Stack(
      fit: StackFit.expand,
      children: [
        onPhoto
            ? PhotoScene(progress: t, photos: photos)
            : VanScene(progress: t),
        SafeArea(
          child: Align(
            alignment: const Alignment(0, -.62),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: intro,
                    child: Transform.translate(
                      offset: Offset(0, 14 * (1 - intro)),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          TowrisBrand.name,
                          style: textTheme.displayLarge?.copyWith(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                            height: 1,
                            color: titleColor,
                            shadows: shadows,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: sloganIn,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - sloganIn)),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          TowrisBrand.slogan,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: sloganSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3.2,
                            color: sloganColor,
                            shadows: shadows,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
