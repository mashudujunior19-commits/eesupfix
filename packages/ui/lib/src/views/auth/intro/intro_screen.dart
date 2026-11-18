import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/themes/towris_brand.dart';
import 'package:ui/src/views/auth/intro/intro_scenes.dart';

/// One page of the intro: an animated scene, a title and a short line.
class IntroPage {
  const IntroPage({
    required this.title,
    required this.body,
    required this.scene,
  });

  final String title;
  final String body;
  final IntroSceneKind scene;
}

/// The short "what is Towris" pages new users see after the start-up
/// animation and before the sign-in page, until someone has signed in on the
/// device (see `IntroSeen`).
@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const pages = [
    IntroPage(
      title: 'Shop for food, together',
      body: 'Groceries and household essentials at bulk prices, '
          'delivered to your community.',
      scene: IntroSceneKind.shop,
    ),
    IntroPage(
      title: 'Join a KasiPool',
      body: 'Team up with your neighbours. Combine your orders, unlock '
          'lower prices and collect from one spot.',
      scene: IntroSceneKind.pool,
    ),
    IntroPage(
      title: 'Earn rewards',
      body: 'Get rewarded when you shop and when friends join with your '
          'referral code. Own your economy.',
      scene: IntroSceneKind.rewards,
    ),
  ];

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == IntroScreen.pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _finish({required bool register}) {
    // Sign-in stays underneath, so Back from sign-up lands on it.
    context.router.replaceAll([
      const SignInRoute(),
      if (register) const RegisterRoute(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final page = IntroScreen.pages[_index];

    return Scaffold(
      key: const Key('intro_screen'),
      backgroundColor: Colors.white,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, .62, .62],
            colors: [IntroColors.wash, Colors.white, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                showSkip: !_isLast,
                onSkip: () => _finish(register: false),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: IntroScreen.pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntroScene(
                      kind: IntroScreen.pages[i].scene,
                      active: i == _index,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Progress(count: IntroScreen.pages.length, index: _index),
                    const SizedBox(height: 20),
                    // Same height on every page, so the button never jumps.
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 112),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        switchInCurve: Curves.easeOutCubic,
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0, .08),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        layoutBuilder: (current, previous) => Stack(
                          alignment: Alignment.topLeft,
                          children: [...previous, if (current != null) current],
                        ),
                        child: Column(
                          key: ValueKey(_index),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sizes are set here: the app theme's headline
                            // is smaller than its body text.
                            Text(
                              page.title,
                              style: textTheme.headlineSmall?.copyWith(
                                fontSize: 28,
                                height: 1.15,
                                letterSpacing: -.6,
                                color: TowrisBrand.ink,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              page.body,
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: IntroColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        key: const Key('intro_next'),
                        style: FilledButton.styleFrom(
                          backgroundColor: TowrisBrand.deepGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed:
                            _isLast ? () => _finish(register: true) : _next,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLast ? 'Get Started' : 'Next',
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            if (!_isLast) ...[
                              const SizedBox(width: 10),
                              const Icon(BootstrapIcons.arrow_right, size: 18),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextButton(
                      key: const Key('intro_sign_in'),
                      onPressed: () => _finish(register: false),
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: IntroColors.muted,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                                color: TowrisBrand.deepGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.showSkip, required this.onSkip});

  final bool showSkip;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 12, 0),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
              semanticLabel: 'Towris',
              errorBuilder: (_, __, ___) => const SizedBox(height: 40),
            ),
            const Spacer(),
            AnimatedOpacity(
              opacity: showSkip ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: TextButton(
                key: const Key('intro_skip'),
                onPressed: showSkip ? onSkip : null,
                style: TextButton.styleFrom(
                  foregroundColor: TowrisBrand.ink,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Segmented progress, one segment per page; the current one is longer.
class _Progress extends StatelessWidget {
  const _Progress({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.only(right: 6),
            width: i == index ? 28 : 10,
            height: 6,
            decoration: BoxDecoration(
              color: i <= index ? TowrisBrand.green : IntroColors.track,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
