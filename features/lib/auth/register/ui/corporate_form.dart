import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class CorporateForm extends StatelessWidget {
   CorporateForm({super.key, required this.tabController});
  final TabController tabController;
  final _corpNameController = TextEditingController();
  final _corpRegController = TextEditingController();
  final _npcRegController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ListView(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 100),
      children: [
        25.sH,
        Text(
          'Corporate account details',
          style: textTheme.labelMedium?.copyWith(fontSize: 18),
          textAlign: TextAlign.left,
        ),
        25.sH,
        EESUpTextFormField(
          label: 'Company Name',
          isRequired: true,
          controller: _corpNameController,
          hintText: 'EESUp',
        ).animate().slideIn(0),
        if (1==1)
          EESUpTextFormField(
            label: 'NPC Registration Number',
            controller: _npcRegController,
            hintText: 'Optional',
          ).animate().slideIn(100)
        else
          EESUpTextFormField(
            label: 'Company Registration',
            controller: _corpRegController,
            hintText: 'Optional',
          ).animate().slideIn(100),
        25.sH,
        ElevatedButton(
          onPressed: () {
            // updateCorpName(ref, _corpNameController.text);
            // updateCorpReg(ref, _corpRegController.text);
            // updateNpcReg(ref, _npcRegController.text);

            // if (readSignUp(ref).corpName != null) {
            //   widget.tabController.animateTo(2);
            // } else {
            //   showSnackBar(
            //     context: context,
            //     message: 'Please enter corporate name',
            //     type: SnackBarType.error,
            //   );
            // }
          },
          child: const Text('Next'),
        ).animate().slideIn(200),
      ],
    );
  }
}
