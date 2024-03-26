import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

Future<Object?> searchTransferBeneficiaryDialog(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return const _SearchTransferBeneficiary();
    },
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeIn,
    duration: 400.ms,
  );
}

// final _searchBeneficiaryProvider = FutureProvider.family
//     .autoDispose<List<dynamic>, String>((ref, query) async {
//   final repo = ref.read(walletRepoProvider);
//   final results = await repo.searchTransferBeneficiary(query);
//   return results.fold((l) {
//     throw l;
//   }, (r) => r);
// });

class _SearchTransferBeneficiary extends StatefulWidget {
  const _SearchTransferBeneficiary({super.key});

  @override
  State<_SearchTransferBeneficiary> createState() =>
      __SearchTransferBeneficiaryState();
}

class __SearchTransferBeneficiaryState
    extends State<_SearchTransferBeneficiary> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> found = {};
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          top: context.height * .2,
        ),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Transform.scale(
              scale: .95,
              child: EESUpTextFormField(
                hintText: 'Search referral code, first name, last name...',
                readOnly: false,
                type: TextInputType.text,
                controller: _searchController,
                onChanged: (v) => setState(() {}),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: found.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: context.colorScheme.primary.withOpacity(
                    .5,
                  ),
                  child: const Icon(
                    BootstrapIcons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  found[index]['full_name'] ?? found[index]['corp_name'],
                ),
                subtitle: Text(
                  found[index]['description'] + ' wallet',
                ),
                trailing: const Icon(
                  IconlyLight.arrowRight2,
                  size: 20,
                ),
                onTap: () {
                  Navigator.pop(context, found[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
