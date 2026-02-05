import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/invite_members_dialog.dart';

@RoutePage()
class CreateEESUpoolScreen extends StatefulWidget {
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
  State<CreateEESUpoolScreen> createState() => _CreateEESUpoolScreenState();
}

class _CreateEESUpoolScreenState extends State<CreateEESUpoolScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Clear any previous values
    _nameController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createPool() async {
    // Validate name
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      context.snackBarError('Please enter a pool name');
      return;
    }
    if (name.length < 3) {
      context.snackBarError('Pool name must be at least 3 characters');
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    final descr = _descriptionController.text.trim();
    final repo = context.read<EESUpoolRepository>();

    final result = await repo.createEESUpool(
      name: name,
      description: descr.isEmpty ? null : descr,
      parent: widget.parentId,
      level: widget.level,
      type: widget.type,
    );

    // Check if widget is still mounted before using context
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    result.fold((l) {
      context.snackBarError(l.message);
    }, (id) {
      if (id != null) {
        context.snackBarSuccess('Kasipool created, invite members to join');
        // Pop the creation screen first, then show invite dialog
        Navigator.of(context).pop();
        context.showBottomSheetDialog(
          child: InviteMembersDialog(poolId: id, isNewPool: false),
        );
      } else {
        context.snackBarError(
          'Kasipool could not be created. Please try again',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Kasipool'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 500,
          left: 25,
          right: 25,
        ),
        children: [
          _PoolDetailsForm(
            nameController: _nameController,
            descriptionController: _descriptionController,
          ),
          25.sH,
          ElevatedButton(
            onPressed: _isLoading ? null : _createPool,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Create'),
          )
        ],
      ),
    );
  }
}

class _PoolDetailsForm extends StatelessWidget {
  const _PoolDetailsForm({
    required this.nameController,
    required this.descriptionController,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;

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
          'Kasipools are a great way to save money and communicate with your community, friends and family. Create an Kasipool and invite your friends and family to join you.',
          textAlign: TextAlign.center,
        ),
        15.sH,
        const Text(
          'Create a new Kasipool now',
          textAlign: TextAlign.center,
        ),
        EESUpTextFormField(
          label: "Name",
          isRequired: true,
          controller: nameController,
        ),
        EESUpTextFormField(
          label: "Description",
          maxLines: 5,
          controller: descriptionController,
        ),
      ],
    );
  }
}
