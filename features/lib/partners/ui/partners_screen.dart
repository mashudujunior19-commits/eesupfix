import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'partner_card.dart';

// final _partnersProvider =
//     FutureProvider.autoDispose<List<Partner>>((ref) async {
//   final repo = ref.watch(partnerRepoProvider);
//   final results = await repo.fetchPartnerships();
//   return results.fold(
//     (l) => throw l,
//     (r) => r,
//   );
// });

class PartnerScreens extends StatelessWidget {
  const PartnerScreens({super.key});
  static const String route = '/partners-screen';

  @override
  Widget build(BuildContext context) {
    final partners = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Services'),
        ),
        body: Container(
          decoration: context.bgImage,
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: partners.length,
            itemBuilder: (context, index) {
              final partner = partners[index];
              return PartnerCard(partner: partner)
                  .animate()
                  .slideIn(index * 50);
            },
          ),
        ),
      ),
    );
  }
}
