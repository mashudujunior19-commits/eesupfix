import 'package:data_sources/finance/models/wallet.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/finances/wallets/ui/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// final walletsProvider = FutureProvider.autoDispose<List<Wallet>>((ref) async {
//   final repo = ref.read(walletRepoProvider);
//   final result = await repo.fetchWallets();
//   return result.fold((l) {
//     throw l;
//   }, (r) {
//     r.sort((a, b) => a.sortNumber.compareTo(b.sortNumber));
//     return r;
//   });
// });

class WalletsView extends StatelessWidget {
  const WalletsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Wallet> wallets = [];
    return ListView.builder(
      itemCount: wallets.length,
      itemBuilder: (context, index) {
        final wallet = wallets[index];
        return WalletCard(wallet: wallet).animate().slideIn(index * 50);
      },
    );
  }
}
