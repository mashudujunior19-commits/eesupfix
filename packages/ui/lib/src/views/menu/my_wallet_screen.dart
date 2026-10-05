import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/views/finances/wallets/ui/screens/wallets_tab.dart';

@RoutePage()
class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('My Wallet'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: context.bgImage,
        child: const WalletsTab(),
      ),
    );
  }
}
