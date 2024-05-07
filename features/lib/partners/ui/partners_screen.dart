import 'package:auto_route/auto_route.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:data_sources/partners/data_source/partner_supabase_impl.dart';
import 'package:features/auth/profile/bloc/profile_bloc.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/partners/bloc/partners_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/partners/partner_repository.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'partner_card.dart';

@RoutePage()
class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key, required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnersBloc(context.read<PartnerRepository>())
        ..add(PartnersFetched(role)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Available Services'),
          ),
          body: Container(
            decoration: context.bgImage,
            width: double.infinity,
            height: double.infinity,
            child: BlocBuilder<PartnersBloc, PartnersState>(
              builder: (context, state) {
                if (state is PartnersLoaded) {
                  final partners = state.applications;
                  return ListView.builder(
                    itemCount: partners.length,
                    itemBuilder: (context, index) {
                      final partner = partners[index];
                      return PartnerCard(partner: partner)
                          .animate()
                          .slideIn(index * 50);
                    },
                  );
                } else if (state is PartnersLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is PartnersError) {
                  return FullScreenError(exception: state.error);
                } else {
                  return FullScreenError(
                    exception: EESUpException(message: ''),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
