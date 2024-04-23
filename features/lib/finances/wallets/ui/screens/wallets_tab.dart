import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/finances/wallets/bloc/wallets_bloc.dart';
import 'package:features/finances/wallets/ui/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class WalletsTab extends StatelessWidget {
  const WalletsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletsBloc, WalletsState>(
      bloc: WalletsBloc(context.read<WalletsRepository>())
        ..add(WalletsFetched()),
      builder: (context, state) {
        if (state is WalletsLoaded) {
          return ListView.builder(
            itemCount: state.wallets.length,
            itemBuilder: (context, index) {
              final wallet = state.wallets[index];
              return WalletCard(
                wallet: wallet
               
              ).animate().slideIn(
                    index * 50
                  );
            },
          );
        } else if (state is WalletsLoading) {
          return const FullScreenLoadingShimmer();
        } else if (state is WalletsLoadingError) {
          return FullScreenError(exception: state.error);
        } else {
          return FullScreenError(
            exception: EESUpException(
              message: 'We had a proble while'
                  ' proccessing the request.',
            ),
          );
        }
      },
    );
  }
}
