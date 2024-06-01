import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/eesupreneur/data_source/eesupreneur_supabase_data_soruce.dart';
import 'package:data/partners/repository/eesupreneur_repository.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/kasipreneur/bloc/kasipreneur_bloc.dart';
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KasipreneurTab extends StatelessWidget {
  const KasipreneurTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EESUpreneurRepository(
        EESUpreneurSupabaseDataSource(GetIt.I.get<SupabaseClient>()),
        context.read<AuthRepository>(),
      ),
      child: BlocProvider(
        create: (context) => KasipreneurBloc(
          context.read<EESUpreneurRepository>(),
        )..add(KasipreneurFetched()),
        child: BlocBuilder<KasipreneurBloc, KasipreneurState>(
          builder: (context, state) {
            if (state is KasipreneurInitial) {
              return const FullScreenLoadingShimmer();
            } else if (state is KasipreneursLoaded) {
              if (state.kasipreneurs.isEmpty) {
                return FullScreenError(
                  isError: false,
                  exception:
                      EESUpException(message: 'Oops!! nothing to show here'),
                );
              }
              return ListView.builder(
                itemCount: state.kasipreneurs.length,
                itemBuilder: (context, index) {
                  return KasipreneurCard(eesupreneur: state.kasipreneurs[index])
                      .animate()
                      .slideIn(50.00 * index);
                },
              );
            } else if (state is KasipreneursError) {
              return FullScreenError(exception: state.exception);
            } else {
              return FullScreenError(
                exception: EESUpException(
                  message: 'We had a proble while'
                      ' proccessing the request.',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
