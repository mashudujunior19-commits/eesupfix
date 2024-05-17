import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/finance/data_source/voucher_supabase_dt.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/finances/crowdvouchers/bloc/user_vouchers_bloc.dart';
import 'package:ui/src/features/finances/crowdvouchers/ui/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VouchersTab extends StatelessWidget {
  const VouchersTab({super.key, required this.walletId});
  final int walletId;

  @override
  Widget build(BuildContext context) {
    final repo = VoucherRepository(
      context.read<AuthRepository>(),
      VoucherSupabaseDt(GetIt.I<SupabaseClient>()),
    );

    return BlocProvider(
      create: (context) => UserVouchersBloc(repo, walletId)
        ..add(
          FetchUserVouchersEvent(),
        ),
      child: BlocBuilder<UserVouchersBloc, UserVouchersState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton.small(
              backgroundColor: context.colorScheme.primary,
              onPressed: () {
                // context.push(NewVoucherScreen.route).whenComplete(() {
                //   context
                //       .read<UserVouchersBloc>()
                //       .add(FetchUserVouchersEvent());
                //   context
                //       .read<CrowdfundVoucherBloc>()
                //       .add(CrowdfundVoucherLoadEvent());
                // });
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: () {
              if (state is UserVouchersLoadedState) {
                if (state.vouchers.isEmpty) {
                  return Center(
                    child: FullScreenError(
                      isError: false,
                      exception: EESUpException(
                        message: 'You don\'t have any vouchers yet, Tap the +'
                            ' button to create a new voucher',
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 300),
                  itemCount: state.vouchers.length,
                  itemBuilder: (context, index) {
                    return VoucherCard(voucher: state.vouchers[index])
                        .animate()
                        .slideIn((30 * index).toDouble());
                  },
                );
              } else if (state is UserVouchersErrorState) {
                return FullScreenError(
                  isError: false,
                  exception: state.error,
                );
              } else if (state is UserVouchersBusyState) {
                return const FullScreenLoadingShimmer();
              }
            }(),
          );
        },
      ),
    );
  }
}
