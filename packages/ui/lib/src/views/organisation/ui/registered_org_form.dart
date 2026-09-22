import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/organisation/cubit/organisation_cubit.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';
import 'package:ui/src/views/organisation/ui/widgets/document_specs.dart';
import 'package:ui/src/views/organisation/ui/widgets/document_upload_field.dart';

class RegisteredOrgForm extends StatefulWidget {
  const RegisteredOrgForm({
    super.key,
    required this.form,
    required this.tabController,
  });

  final OrganisationForm form;
  final TabController tabController;

  @override
  State<RegisteredOrgForm> createState() => _RegisteredOrgFormState();
}

class _RegisteredOrgFormState extends State<RegisteredOrgForm> {
  bool _isSubmitting = false;

  OrganisationForm get form => widget.form;
  TabController get tabController => widget.tabController;

  @override
  Widget build(BuildContext context) {
    final documentTypes = [
      ...form.requiredDocumentTypes,
      ...form.optionalDocumentTypes,
    ];

    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 60),
      children: [
        EESUpTextFormField(
          initialValue: form.organisationName,
          label: 'Name of Business/Organisation',
          hintText: 'Enter your business name',
          isRequired: true,
          onChanged: (value) =>
              _update(organisationName: value.isEmpty ? null : value),
        ).animate().slideIn(0),
        EESUpTextFormField(
          initialValue: form.industryType,
          label: 'Industry Type',
          hintText: 'e.g Soccer Club',
          isRequired: true,
          onChanged: (value) =>
              _update(industryType: value.isEmpty ? null : value),
        ).animate().slideIn(50),
        20.sH,
        Text(
          'Upload Documents',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 16),
        ).animate().slideIn(100),
        for (final type in documentTypes)
          DocumentUploadField(
            label: docSpecs[type]!.label,
            hint: docSpecs[type]!.hint,
            isRequired: form.requiredDocumentTypes.contains(type),
            allowedExtensions: docSpecs[type]!.extensions,
            pickedFile: form.pickedDocuments[type],
            isUploading: form.uploadingDocuments.contains(type),
            isUploaded: form.uploadedDocumentPaths[type] != null,
            onFilePicked: (file) =>
                context.read<OrganisationCubit>().pickDocument(type, file),
          ).animate().slideIn(150),
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

  void _update({String? organisationName, String? industryType}) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(
            organisationName: organisationName ?? form.organisationName,
            industryType: industryType ?? form.industryType,
          ),
        );
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (form.organisationName == null ||
        form.organisationName!.trim().isEmpty) {
      context.snackBarError('Please provide the business/organisation name.');
      return;
    }
    if (form.industryType == null || form.industryType!.trim().isEmpty) {
      context.snackBarError('Please provide the industry type.');
      return;
    }
    if (!form.hasAllRequiredDocuments) {
      context.snackBarError('Please upload all required documents.');
      return;
    }

    setState(() => _isSubmitting = true);
    await context.read<OrganisationCubit>().submit();
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    final status = context.read<OrganisationCubit>().state.status;
    if (status == OrganisationSubmitStatus.success) {
      tabController.animateTo(tabController.index + 1);
    } else if (status == OrganisationSubmitStatus.failed) {
      final message = context.read<OrganisationCubit>().state.errorMessage;
      context.snackBarError(message ?? 'Something went wrong.');
    }
  }
}
