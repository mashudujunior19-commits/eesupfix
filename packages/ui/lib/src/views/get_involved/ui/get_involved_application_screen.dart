import 'package:auto_route/auto_route.dart';
import 'package:data/get_involved/models/get_involved_application_type.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/eesup_scaffold.dart';
import 'package:ui/src/views/organisation/ui/widgets/organisation_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/get_involved/cubit/get_involved_cubit.dart';
import 'package:ui/src/views/get_involved/cubit/get_involved_form.dart';

/// A lightweight "Get Involved" application: any business -- registered or
/// not -- can submit interest without going through the full "Register an
/// Organisation" wizard (which requires an address, VAT/PBO numbers, etc).
@RoutePage()
class GetInvolvedApplicationScreen extends StatelessWidget {
  const GetInvolvedApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetInvolvedCubit(context.read<GetInvolvedRepository>()),
      child: BlocConsumer<GetInvolvedCubit, GetInvolvedForm>(
        listener: (context, state) {
          if (state.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return EESUpScaffold(
            body: Scaffold(
              appBar: AppBar(
                title: state.status == GetInvolvedSubmitStatus.success
                    ? null
                    : const Text('Get Involved'),
              ),
              body: state.status == GetInvolvedSubmitStatus.success
                  ? const _GetInvolvedSuccessView()
                  : _GetInvolvedForm(form: state),
            ),
          );
        },
      ),
    );
  }
}

class _GetInvolvedForm extends StatefulWidget {
  const _GetInvolvedForm({required this.form});

  final GetInvolvedForm form;

  @override
  State<_GetInvolvedForm> createState() => _GetInvolvedFormState();
}

class _GetInvolvedFormState extends State<_GetInvolvedForm> {
  bool _isSubmitting = false;

  GetInvolvedForm get form => widget.form;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 60),
      children: [
        Text(
          'Tell us about your business',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 16),
        ).animate().slideIn(0),
        10.sH,
        OrganisationOptionTile(
          title: 'Registered Business',
          subtitle: 'My business is formally registered.',
          isSelected:
              form.applicationType == GetInvolvedApplicationType.registered,
          onTap: () => _updateType(GetInvolvedApplicationType.registered),
        ).animate().slideIn(50),
        10.sH,
        OrganisationOptionTile(
          title: 'Unregistered Business',
          subtitle: 'My business is not formally registered.',
          isSelected:
              form.applicationType == GetInvolvedApplicationType.unregistered,
          onTap: () => _updateType(GetInvolvedApplicationType.unregistered),
        ).animate().slideIn(100),
        if (form.applicationType == GetInvolvedApplicationType.registered)
          EESUpTextFormField(
            key: const ValueKey('business_name'),
            initialValue: form.businessName,
            label: 'Business Name',
            hintText: 'Enter your business name',
            isRequired: true,
            onChanged: (value) =>
                _update(businessName: value.isEmpty ? null : value),
          ).animate().slideIn(150)
        else ...[
          EESUpTextFormField(
            key: const ValueKey('first_name'),
            initialValue: form.firstName,
            label: 'Name',
            isRequired: true,
            onChanged: (value) =>
                _update(firstName: value.isEmpty ? null : value),
          ).animate().slideIn(150),
          EESUpTextFormField(
            key: const ValueKey('last_name'),
            initialValue: form.lastName,
            label: 'Surname',
            isRequired: true,
            onChanged: (value) =>
                _update(lastName: value.isEmpty ? null : value),
          ).animate().slideIn(200),
        ],
        EESUpTextFormField(
          key: const ValueKey('business_type'),
          initialValue: form.businessType,
          label: 'Type of Business',
          hintText: 'e.g Internet Cafe',
          isRequired: true,
          onChanged: (value) =>
              _update(businessType: value.isEmpty ? null : value),
        ).animate().slideIn(250),
        30.sH,
        ElevatedButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }

  void _updateType(GetInvolvedApplicationType type) {
    context.read<GetInvolvedCubit>().updateForm(
          form.copyWith(applicationType: type),
        );
  }

  void _update({
    String? businessName,
    String? firstName,
    String? lastName,
    String? businessType,
  }) {
    context.read<GetInvolvedCubit>().updateForm(
          form.copyWith(
            businessName: businessName ?? form.businessName,
            firstName: firstName ?? form.firstName,
            lastName: lastName ?? form.lastName,
            businessType: businessType ?? form.businessType,
          ),
        );
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (form.applicationType == GetInvolvedApplicationType.registered) {
      if (form.businessName == null || form.businessName!.trim().isEmpty) {
        context.snackBarError('Please provide your business name.');
        return;
      }
    } else {
      if (form.firstName == null || form.firstName!.trim().isEmpty) {
        context.snackBarError('Please provide your name.');
        return;
      }
      if (form.lastName == null || form.lastName!.trim().isEmpty) {
        context.snackBarError('Please provide your surname.');
        return;
      }
    }
    if (form.businessType == null || form.businessType!.trim().isEmpty) {
      context.snackBarError('Please provide the type of business.');
      return;
    }

    setState(() => _isSubmitting = true);
    await context.read<GetInvolvedCubit>().submit();
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    final status = context.read<GetInvolvedCubit>().state.status;
    if (status == GetInvolvedSubmitStatus.failed) {
      final message = context.read<GetInvolvedCubit>().state.errorMessage;
      context.snackBarError(message ?? 'Something went wrong.');
    }
  }
}

class _GetInvolvedSuccessView extends StatelessWidget {
  const _GetInvolvedSuccessView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 70),
        20.sH,
        Text(
          'Application submitted!',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        10.sH,
        Text(
          "Thanks for letting us know. We'll be in touch shortly.",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: ElevatedButton(
            child: const Text('Done'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
      ],
    );
  }
}
