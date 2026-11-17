import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui/app_route.gr.dart';
import 'package:video_player/video_player.dart';
import 'package:ui/src/views/auth/landing/photo_scene.dart';
import 'package:ui/src/views/auth/landing/van_scene.dart';
import 'package:ui/src/views/auth/sign_in/bloc/auth_bloc.dart';

/// The auto-playing landing sequence. It plays the Towris landing video
/// (`assets/videos/landing.mp4`, silent, about 3.5 seconds) and then sends the
/// user on to the sign-in page (or straight into the app if they are already
/// signed in). If the video cannot be played the older animated scene below is
/// used instead:
///
/// Fast and tightly timed, starting the moment the app opens:
///
/// 1. A loaded Towris truck drives past while neighbours come out to meet it;
///    the name and slogan sit above the scene (~[sceneDuration]).
/// 2. The scene cuts quickly ([logoFade]) to the centred logo.
/// 3. The logo is held for only [logoHold], then the user is sent on to the
///    sign-in page (or straight into the app if they are already signed in).
///
/// The scene uses real photographs when they are present in
/// `assets/images/landing/` (see [LandingPhotos]) and a vector fallback
/// otherwise.
@RoutePage()
class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  static const Duration sceneDuration = Duration(milliseconds: 3000);
  static const Duration logoFade = Duration(milliseconds: 280);

  static const String videoAsset = 'assets/videos/landing.mp4';

  /// If the video has not started by then, the animated scene is used.
  static const Duration videoStartTimeout = Duration(seconds: 4);

  /// A short beat on the last frame before moving on.
  static const Duration videoEndHold = Duration(milliseconds: 250);

  /// A very short beat on the finished logo before redirecting.
  static const Duration logoHold = Duration(milliseconds: 900);

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

  AuthBlocState? _authState;
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
      _holdTimer = Timer(StartUpScreen.videoEndHold, () {
        _holdFinished = true;
        _tryNavigate();
      });
    }
  }

  bool _fallbackStarted = false;

  void _startFallbackScene() {
    if (_fallbackStarted || _videoReady || !mounted) return;
    _fallbackStarted = true;
    setState(() {});
    // The animation starts right away; the photographs (if any) are picked up
    // as soon as the asset list has been read, which takes a few milliseconds.
    LandingPhotos.load().then((photos) {
      if (mounted) setState(() => _photos = photos);
    });

    _scene.forward().whenComplete(() {
      if (!mounted) return;
      _logo.forward().whenComplete(() {
        if (!mounted) return;
        // The logo is fully visible now: a very short beat, then on.
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
    _videoGuard?.cancel();
    _video?.removeListener(_onVideoTick);
    _video?.dispose();
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
        backgroundColor:
            _videoReady || !_fallbackStarted ? TowrisBrand.night : Colors.white,
        body: _videoReady
            ? Center(
                child: AspectRatio(
                  aspectRatio: _video!.value.aspectRatio,
                  child: VideoPlayer(_video!),
                ),
              )
            : !_fallbackStarted
                ? const SizedBox.expand()
                : AnimatedBuilder(
                    animation: Listenable.merge([_scene, _logo]),
                    builder: (context, _) {
                      final logoT = Curves.easeOutCubic.transform(_logo.value);
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: 1 - logoT,
                            child:
                                _SceneLayer(t: _scene.value, photos: _photos),
                          ),
                          if (_logo.value > 0)
                            Center(
                              child: Opacity(
                                opacity: logoT,
                                child: Transform.scale(
                                  scale: .88 + .12 * logoT,
                                  child: SizedBox(
                                    width: math.min(
                                      MediaQuery.sizeOf(context).width * .55,
                                      MediaQuery.sizeOf(context).height * .3,
                                    ),
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
