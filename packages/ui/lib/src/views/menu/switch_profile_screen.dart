import 'package:auto_route/auto_route.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/get_involved/models/profile_switch_state.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/auth/profile/bloc/profile_bloc.dart';

/// Lets someone with an approved Get Involved application move between their
/// Individual profile and their Business profile. The Business profile behaves
/// like a Corporate account everywhere (wallets, roles, partner rules), so the
/// whole app is rebuilt after a switch.
///
/// Reached from the menu, and only shown there once an application is approved.
class SwitchProfileScreen extends StatefulWidget {
  const SwitchProfileScreen({super.key, required this.profile});

  final Profile profile;

  @override
  State<SwitchProfileScreen> createState() => _SwitchProfileScreenState();
}

class _SwitchProfileScreenState extends State<SwitchProfileScreen> {
  ProfileSwitchState? _state;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await context.read<GetInvolvedRepository>().profileSwitchState();
    if (!mounted) return;
    result.fold(
      (e) => setState(() => _error = e.message),
      (s) => setState(() => _state = s),
    );
  }

  String get _individualName {
    final n = [widget.profile.firstName, widget.profile.lastName]
        .whereType<String>()
        .join(' ')
        .trim();
    return n.isEmpty ? 'My individual profile' : n;
  }

  Future<void> _switchTo({required bool business}) async {
    final state = _state;
    if (state == null || _busy || state.businessActive == business) return;

    final confirmed = await context.confirmAction(
      business ? 'Switch to your business profile?' : 'Switch to your individual profile?',
      business
          ? 'You will use TOWRIS as ${state.businessName ?? 'your business'}. '
              'Business accounts follow the Corporate rules: for example you '
              'will see your Retail and Social wallets only. Nothing is lost; '
              'switch back at any time.'
          : 'You will go back to your individual profile and all of its '
              'wallets and features.',
      confirmText: 'Switch',
    );
    if (!confirmed || !mounted) return;

    setState(() => _busy = true);
    final result = await context
        .read<GetInvolvedRepository>()
        .switchProfile(toBusiness: business);
    if (!mounted) return;

    final failure = result.fold((e) => e.message, (_) => null);
    if (failure != null) {
      setState(() => _busy = false);
      context.snackBarError(failure);
      return;
    }

    // Bring the profile up to date, then rebuild the app from Home so every
    // screen (wallets, menu, partners) uses the profile now in effect.
    final router = context.router;
    final bloc = context.read<ProfileBloc>();
    final fresh = (await context.read<ProfileRepository>().fetchSessionProfile())
        .fold((l) => null, (r) => r);
    if (fresh != null) bloc.add(ProfileReloaded(fresh));
    if (!mounted) return;
    context.snackBarSuccess(business
        ? 'You are now using your business profile.'
        : 'You are now using your individual profile.');
    router.root.replaceAll([const OverviewRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    return Scaffold(
      appBar: AppBar(title: const Text('Switch profile')),
      body: SafeArea(
        child: _error != null
            ? Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(_error!)))
            : state == null
                ? const Center(child: CircularProgressIndicator())
                : !state.available
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'Your business profile is available once your '
                            'Get Involved application is approved.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          Text(
                            'Choose the profile you want to use.',
                            style: context.textTheme.labelMedium
                                ?.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          _ProfileOption(
                            icon: IconlyBold.profile,
                            title: _individualName,
                            subtitle: 'Individual profile',
                            active: !state.businessActive,
                            onTap: () => _switchTo(business: false),
                          ),
                          const SizedBox(height: 12),
                          _ProfileOption(
                            icon: MdiIcons.officeBuildingOutline,
                            title: state.businessName ?? 'My business',
                            subtitle: 'Business profile',
                            active: state.businessActive,
                            onTap: () => _switchTo(business: true),
                          ),
                          if (_busy)
                            const Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.primary;
    return Semantics(
      button: true,
      selected: active,
      label: '$subtitle, $title${active ? ', in use' : ''}',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: active ? null : onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active ? color : Colors.grey.shade300,
              width: active ? 1.6 : .6,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(.12),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
              if (active)
                Icon(Icons.check_circle, color: color)
              else
                const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
