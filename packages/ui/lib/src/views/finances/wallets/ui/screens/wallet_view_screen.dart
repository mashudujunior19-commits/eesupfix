import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/models/wallet_balance.dart';
import 'package:data/finance/models/wallet_rules.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/views/finances/wallets/ui/screens/commit_screen.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/finances/wallets/bloc/wallet_view_bloc.dart';
import 'package:ui/src/views/finances/wallets/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:data/utils/double_ext.dart';

@RoutePage()
class WalletViewScreen extends StatelessWidget {
  const WalletViewScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletViewBloc(context.read<WalletsRepository>())
        ..add(WalletViewFetched(id)),
      child: SizedBox(
        child: Scaffold(
          body: Container(
            decoration: context.bgImage,
            height: context.height,
            child: BlocBuilder<WalletViewBloc, WalletViewState>(
              builder: (context, state) {
                // if (state is WalletViewLoaded) {

                //   final wallet = state.wallet;
                //   final transactions = state.transactions;
                //   return Column(
                //     children: [
                //       Container(
                //         width: context.width,
                //         color: Colors.white,
                //         padding: const EdgeInsets.only(
                //           left: 5,
                //           right: 15,
                //           top: 5,
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             const BackButton(),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.end,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 10.sH,
                //                 Text(
                //                   '${wallet.description} wallet',
                //                   style: context.textTheme.labelMedium,
                //                 ),
                //                 Text(
                //                   '${wallet.id}',
                //                   style: context.textTheme.bodySmall?.copyWith(
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         child: ListView(
                //           children: [
                //             Container(
                //               margin: const EdgeInsets.only(bottom: 10),
                //               padding: const EdgeInsets.only(
                //                 left: 20,
                //                 right: 20,
                //                 top: 15,
                //                 bottom: 15,
                //               ),
                //               width: double.infinity,
                //               color: Colors.white,
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   _BalanceCard(wallet: wallet),
                //                   _Transact(wallet: wallet)
                //                 ],
                //               ),
                //             ).animate().slideIn(0),
                //             Padding(
                //               padding: const EdgeInsets.only(left: 20),
                //               child: Text(
                //                 'Activity',
                //                 style: context.textTheme.labelMedium,
                //                 textAlign: TextAlign.start,
                //               ),
                //             ),
                //             for (int i = 0; i < transactions.length; i++)
                //               TransactionCard(transaction: transactions[i])
                //                   .animate()
                //                   .slideIn(i * 50),
                //             300.sH,
                //           ],
                //         ),
                //       ),
                //     ],
                //   );
                // }
                if (state is WalletViewLoaded) {
                  final wallet = state.wallet;
                  final transactions = state.transactions;
                  final balance = state.balance;
                  return Column(
                    children: [
                      Container(
                        width: context.width,
                        color: Colors.white,
                        padding:
                            const EdgeInsets.only(left: 5, right: 15, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                10.sH,
                                Text('${wallet.description} wallet',
                                    style: context.textTheme.labelMedium),
                                Text('${wallet.id}',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontSize: 12)),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _BalanceCard(balance: balance),
                                  _Transact(
                                    wallet: wallet,
                                    availableBalance:
                                        balance.availableBalance ?? 0,
                                  )
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
                            if (transactions.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 40),
                                child: Column(
                                  children: [
                                    Icon(
                                      BootstrapIcons.receipt,
                                      size: 40,
                                      color: Colors.grey.shade400,
                                    ),
                                    10.sH,
                                    Text(
                                      'No transactions yet',
                                      style: context.textTheme.labelMedium,
                                    ),
                                    5.sH,
                                    Text(
                                      'Activity on this wallet will show up here.',
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              )
                            else
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
  const _Transact({required this.wallet, required this.availableBalance});
  final Wallet wallet;
  final double availableBalance;

  void _refresh(BuildContext context) {
    context.read<WalletViewBloc>().add(WalletViewFetched(wallet.id));
  }

  /// Wealth funds are committed to projects, never transferred or paid out.
  Future<void> _commit(BuildContext context) async {
    if (!canCommitWithBalance(availableBalance)) {
      context.snackBarError(
        'You need more than R${minWealthCommitBalance.toStringAsFixed(0)} in '
        'your Wealth wallet to commit to a project. Current available '
        'balance: R${availableBalance.toRounded()}.',
      );
      return;
    }
    final repo = context.read<WalletsRepository>();
    final projects = await repo.fetchFundableProjects();
    if (!context.mounted) return;
    projects.fold(
      (l) => context.snackBarError(l.message),
      (list) {
        if (list.isEmpty) {
          context.snackBarError(
              'There are no approved projects open for funding right now.');
          return;
        }
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (_) => CommitScreen(
                wallet: wallet,
                availableBalance: availableBalance,
                projects: list,
              ),
            ))
            .then((_) {
          if (context.mounted) _refresh(context);
        });
      },
    );
  }

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
        // Wealth: only "Commit" (greyed until the balance allows it).
        if (wallet.canCommit) {
          final allowed = canCommitWithBalance(availableBalance);
          final color = allowed ? null : Colors.grey;
          return [
            PopupMenuItem(
              onTap: () => _commit(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(BootstrapIcons.graph_up_arrow, size: 15, color: color),
                  10.sW,
                  Text('Commit',
                      style:
                          context.textTheme.labelSmall?.copyWith(color: color)),
                ],
              ),
            ),
          ];
        }
        return [
          PopupMenuItem(
            onTap: () {
              context.router.push(TransferRoute(wallet: wallet)).then(
                (value) {
                  _refresh(context);
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
          // Social wallets can never be paid out as cash.
          if (wallet.canRequestPayout)
            PopupMenuItem(
              onTap: () {
                context.router.push(PayoutRoute(wallet: wallet)).then(
                  (value) {
                    _refresh(context);
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // A cash icon: amounts are in Rand, not Euro.
                  const Icon(BootstrapIcons.cash_coin, size: 16),
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

// class _BalanceCard extends StatelessWidget {
//   const _BalanceCard({required this.wallet});
//   final Wallet wallet;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Total balance",
//           style: context.textTheme.labelMedium!.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           wallet.balance < 0
//               ? '- R${wallet.balance.toRounded().substring(1)}'
//               : 'R${wallet.balance.toRounded()}',
//           style: context.textTheme.labelLarge!.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 25,
//           ),
//         ),
//         Text(
//           "Available balance",
//           style: context.textTheme.labelMedium!.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           wallet.balance < 0
//               ? '- R${wallet.balance.toRounded().substring(1)}'
//               : 'R${wallet.balance.toRounded()}',
//           style: context.textTheme.labelLarge!.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 25,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.balance});
  final WalletBalance balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Balance",
          style: context.textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          balance.totalBalance! < 0
              ? '- R${balance.totalBalance!.toRounded().substring(1)}'
              : 'R${balance.totalBalance!.toRounded()}',
          style: context.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: balance.totalBalance! < 0 ? Colors.red : Colors.black,
          ),
        ),
        Text(
          "Available balance",
          style: context.textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          balance.availableBalance! < 0
              ? '- R${balance.availableBalance!.toRounded().substring(1)}'
              : 'R${balance.availableBalance!.toRounded()}',
          style: context.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
