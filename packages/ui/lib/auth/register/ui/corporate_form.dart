import 'package:ui/auth/register/bloc/registration_bloc.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorporateForm extends StatelessWidget {
  const CorporateForm({
    super.key,
    required this.tabController,
    required this.form,
  });
  final SignUpForm form;
  final TabController tabController;
  // final _corpNameController = TextEditingController();
  // final _corpRegController = TextEditingController();
  // final _npcRegController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 100),
      children: [
        25.sH,
        Text(
          'Corporate account details',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
          textAlign: TextAlign.left,
        ),
        25.sH,
        EESUpTextFormField(
          label: 'Company Name',
          isRequired: true,
          hintText: 'EESUp',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;

            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(form.copyWith(lastName: v)),
                );
          },
        ).animate().slideIn(0),
        if (1 == 1)
          const EESUpTextFormField(
            label: 'NPC Registration Number',
            hintText: 'Optional',
          ).animate().slideIn(100)
        else
          const EESUpTextFormField(
            label: 'Company Registration',
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
