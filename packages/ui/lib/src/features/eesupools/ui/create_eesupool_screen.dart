import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/features/eesupools/ui/tabs/members/ui/invites_list_view.dart';

final _nameController = TextEditingController();
final _descriptionController = TextEditingController();

@RoutePage()
class CreateEESUpoolScreen extends StatelessWidget {
  const CreateEESUpoolScreen({
    super.key,
    this.parentId,
    this.level,
    required this.type,
  });
  final int? parentId;
  final EESUpoolLevel? level;
  final EESUpoolType type;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Create EESUpool'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 500,
            left: 25,
            right: 25,
          ),
          children: [
            const _PoolDetailsForm(),
            25.sH,
            ElevatedButton(
              onPressed: () async {
                final descr = _descriptionController.text;
                final repo = context.read<EESUpoolRepository>();
                context.loaderOverlay.show();
                final result = await repo.createEESUpool(
                  name: _nameController.text,
                  description: descr.isEmpty ? null : descr,
                  parent: parentId,
                  level: level,
                  type: type,
                );

                // ignore: use_build_context_synchronously
                context.loaderOverlay.hide();

                result.fold((l) {
                  context.snackBarError(l.message);
                  return;
                }, (id) {
                  if (id != null) {
                    context.snackBarSuccess(
                        'EESUpool created, invite members to join');
                    context.showBottomSheetDialog(
                      child: InviteMembersDialog(poolId: id),
                    );
                  } else {
                    context.snackBarError(
                      'EESUpool could not be created. Please try again',
                    );
                  }
                });
              },
              child: const Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}

class _PoolDetailsForm extends StatelessWidget {
  const _PoolDetailsForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          IconlyLight.user3,
          color: Colors.grey.shade800,
          size: 50,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'EESUpools are a great way to save money and communicate with your community, friends and family. Create an EESUpool and invite your friends and family to join you.',
          textAlign: TextAlign.center,
        ),
        15.sH,
        const Text(
          'Create a new EESUpool now',
          textAlign: TextAlign.center,
        ),
        EESUpTextFormField(
          label: "Name",
          isRequired: true,
          controller: _nameController,
        ),
        EESUpTextFormField(
          label: "Description",
          maxLines: 5,
          controller: _descriptionController,
        ),
      ],
    );
  }
}
