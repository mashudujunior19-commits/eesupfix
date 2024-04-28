import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/finances/wallets/bloc/wallet_view_bloc.dart';
import 'package:features/finances/wallets/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

@RoutePage()
class WalletViewScreen extends StatelessWidget {
  const WalletViewScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletViewBloc(context.read<WalletsRepository>())
        ..add(WalletViewFetched(id)),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: context.bgImage,
            height: context.height,
            child: BlocBuilder<WalletViewBloc, WalletViewState>(
              builder: (context, state) {
                if (state is WalletViewLoaded) {
                  final wallet = state.wallet;
                  final transactions = state.transactions;
                  return Column(
                    children: [
                      Container(
                        width: context.width,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 15,
                          top: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                10.sH,
                                Text(
                                  '${wallet.description} wallet',
                                  style: context.textTheme.labelMedium,
                                ),
                                Text(
                                  '${wallet.id}',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 15,
                                bottom: 15,
                              ),
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _BalanceCard(wallet: wallet),
                                  _Transact(wallet: wallet)
                                ],
                              ),
                            ).animate().slideIn(0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Activity',
                                style: context.textTheme.labelMedium,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            for (int i = 0; i < transactions.length; i++)
                              TransactionCard(transaction: transactions[i])
                                  .animate()
                                  .slideIn(i * 50),
                            300.sH,
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is WalletViewInitial) {
                  return const FullScreenLoadingShimmer(showPopButton: true);
                } else if (state is WalletViewError) {
                  return FullScreenError(
                      exception: state.exception, showPopButton: true);
                } else {
                  return FullScreenError(
                    showPopButton: true,
                    exception: EESUpException(
                      message: 'Something went wrong while'
                          ' proccessing the request.',
                    ),
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

class _Transact extends StatelessWidget {
  const _Transact({required this.wallet});
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(BootstrapIcons.currency_exchange, size: 16),
          5.sW,
          Text('Transact', style: context.textTheme.labelMedium),
          5.sW,
          const Icon(
            IconlyLight.arrowDown2,
            size: 16,
            color: Colors.black,
          )
        ],
      ),
      itemBuilder: (context) {
        return [
          //    if (wallet.transfers == true)
          PopupMenuItem(
            onTap: () {
              context.router.push(TransferRoute(wallet: wallet)).then(
                (value) {
                  context.read<WalletViewBloc>().add(
                        WalletViewFetched(wallet.id),
                      );
                },
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(BootstrapIcons.send, size: 15),
                10.sW,
                Text('Transfer', style: context.textTheme.labelSmall)
              ],
            ),
          ),
          //    if (wallet.withdrawals == true)
          PopupMenuItem(
            onTap: () {
              context.router.push(PayoutRoute(wallet: wallet)).then(
                (value) {
                  context.read<WalletViewBloc>().add(
                        WalletViewFetched(wallet.id),
                      );
                },
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(BootstrapIcons.currency_euro, size: 16),
                10.sW,
                Text('Request payout', style: context.textTheme.labelSmall)
              ],
            ),
          )
        ];
      },
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.wallet});
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your balance",
          style: context.textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          wallet.balance < 0
              ? '- R${wallet.balance.toStringAsFixed(2).substring(1)}'
              : 'R${wallet.balance.toStringAsFixed(2)}',
          style: context.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
