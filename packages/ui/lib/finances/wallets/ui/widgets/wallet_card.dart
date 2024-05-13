import 'package:auto_route/auto_route.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/finances/wallets/bloc/wallets_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/finance/models/wallet.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.wallet});
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.router.push(WalletViewRoute(id: wallet.id)).then((value) {
          context.read<WalletsBloc>().add(WalletsFetched());
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18, top: 15),
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              'assets/images/wallet_background.png',
            ),
          ),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.blueGrey.shade50,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: context.colorScheme.primary.withOpacity(.15),
            child: Icon(IconlyLight.wallet, color: context.colorScheme.primary),
          ),
          title: Text('${wallet.description} wallet'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                '${wallet.id}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
              ),
              const SizedBox(height: 1),
              Text('R${wallet.balance.toStringAsFixed(2)}'),
            ],
          ),
          trailing: const Text('Tap to view'),
        ),
      ),
    );
  }
}
