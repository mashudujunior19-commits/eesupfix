import 'package:auto_route/auto_route.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/partners/bloc/partners_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
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
      child: SizedBox(
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
