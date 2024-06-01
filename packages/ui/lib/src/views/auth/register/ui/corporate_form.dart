import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/auth/register/bloc/registration_bloc.dart';
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

            if (v != null) {
              context.read<RegistrationBloc>().add(
                    CorpFormUpdated(
                      name: v,
                      reg: form.corpReg,
                    ),
                  );
            }
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          label: 'Company Registration',
          hintText: 'Optional',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;

            if (v != null) {
              context.read<RegistrationBloc>().add(
                    CorpFormUpdated(name: form.corpName, reg: v),
                  );
            }
          },
        ).animate().slideIn(100),
        25.sH,
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (form.corpName == null) {
              context.snackBarError('Please fill in the corporate name');
              return;
            }

            tabController.animateTo(tabController.index++);
          },
          child: const Text('Next'),
        ).animate().slideIn(200),
      ],
    );
  }
}
