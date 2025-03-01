import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/views/finances/crowdvouchers/bloc/crowdfund_voucher_bloc.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/crowdfund_wallet_view.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/vouchers_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:data/finance/data_source/wallet_supabase_impl.dart';
import 'package:data/utils/double_ext.dart';

class CrowdfundWalletScreen extends StatelessWidget {
  const CrowdfundWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CrowdfundVoucherBloc(
        WalletsRepository(
          WalletSupabaseImpl(GetIt.I.get<SupabaseClient>()),
          context.read<AuthRepository>(),
        ),
      )..add(CrowdfundVoucherLoadEvent()),
      child: BlocListener<CrowdfundVoucherBloc, CrowdfundVoucherState>(
        listener: (context, state) {
          if (state is CrowdfundVoucherBusyState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        child: BlocBuilder<CrowdfundVoucherBloc, CrowdfundVoucherState>(
          builder: (context, state) {
            if (state is CrowdfundVoucherLoadedState) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 15,
                          bottom: 15,
                        ),
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crowdfund Balance",
                                  style: context.textTheme.labelSmall,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  state.wallet.balance < 0
                                      ? '- R${state.wallet.balance.toRounded().substring(1)}'
                                      : 'R${state.wallet.balance.toRounded()}',
                                  style: context.textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ).animate().slideIn(0),
                      Container(
                        width: context.width,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 27,
                        color: Colors.white,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelColor: Colors.white,
                          labelStyle: context.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: RectangularIndicator(
                            bottomLeftRadius: 8,
                            bottomRightRadius: 8,
                            topLeftRadius: 8,
                            topRightRadius: 8,
                            color: context.colorScheme.primary,
                          ),
                          tabs: const [
                            Tab(text: 'Vouchers'),
                            Tab(text: 'Transactions')
                          ],
                        ),
                      ).animate().slideIn(50),
                      Expanded(
                        child: TabBarView(
                          children: [
                            VouchersTab(walletId: state.wallet.id),
                            CrowdfundWalletView(wallet: state.wallet),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is CrowdfundVoucherErrorState) {
              return FullScreenError(exception: state.error);
            }
            return 0.sW;
          },
        ),
      ),
    );
  }
}
