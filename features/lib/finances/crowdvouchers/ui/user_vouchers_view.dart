import 'package:data_sources/finance/data_source/voucher_supabase_dt.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/crowdvouchers/bloc/user_vouchers_bloc.dart';
import 'package:features/finances/crowdvouchers/ui/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/finances/vourcher_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserVouchersView extends StatelessWidget {
  const UserVouchersView({super.key, required this.walletId});
  final int walletId;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;
    final repo = VoucherRepository(
      getIt<AuthRepository>(),
      VoucherSupabaseDt(
        getIt<SupabaseClient>(),
      ),
    );
    return BlocProvider(
      create: (context) => UserVouchersBloc(repo, walletId)
        ..add(
          FetchUserVouchersEvent(),
        ),
      child: BlocListener<UserVouchersBloc, UserVouchersState>(
        listener: (context, state) {
          if (state is UserVouchersBusyState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
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
                  // if (state.vouchers.isEmpty) {
                  //   return LargeErrorWidget(
                  //     error: EESUpException(
                  //       message: 'You don\'t have any vouchers yet, Tap the +'
                  //           ' button to create a new voucher',
                  //     ),
                  //     topMargin: 50,
                  //   );
                  // }
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
                  return 0.sW;
                }
                return const SizedBox.shrink();
              }(),
            );
          },
        ),
      ),
    );
  }
}
