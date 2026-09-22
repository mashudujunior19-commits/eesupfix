import 'package:data/get_involved/models/contact_person.dart';
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

/// The organisation-details step shown for all four combinations of
/// (Public Benefit / Business) x (Registered / Unregistered): name,
/// industry type, address + contact persons + (for a Registered NPO) its
/// Social Development Number, and the required supporting documents.
class OrganisationDetailsForm extends StatefulWidget {
  const OrganisationDetailsForm({
    super.key,
    required this.form,
    required this.tabController,
  });

  final OrganisationForm form;
  final TabController tabController;

  @override
  State<OrganisationDetailsForm> createState() =>
      _OrganisationDetailsFormState();
}

class _OrganisationDetailsFormState extends State<OrganisationDetailsForm> {
  bool _isSubmitting = false;

  OrganisationForm get form => widget.form;
  TabController get tabController => widget.tabController;

  @override
  Widget build(BuildContext context) {
    final documentTypes = [
      ...form.requiredDocumentTypes,
      ...form.optionalDocumentTypes,
    ];
    final cubit = context.read<OrganisationCubit>();

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
        if (form.requiresOrganisationDetails) ...[
          EESUpTextFormField(
            initialValue: form.address,
            label: 'Address',
            hintText: "Enter the organisation's physical address",
            isRequired: true,
            onChanged: (value) => _update(address: value.isEmpty ? null : value),
          ).animate().slideIn(75),
          if (form.requiresSocialDevelopmentNumber)
            EESUpTextFormField(
              initialValue: form.socialDevelopmentNumber,
              label: 'Social Development Number',
              hintText: 'NPO registration number (Dept. of Social Development)',
              isRequired: true,
              onChanged: (value) => _update(
                socialDevelopmentNumber: value.isEmpty ? null : value,
              ),
            ).animate().slideIn(85),
          20.sH,
          Row(
            children: [
              Expanded(
                child: Text(
                  form.maxContactPersons > 1
                      ? 'Contact Persons'
                      : 'Contact Person',
                  style: context.textTheme.labelMedium?.copyWith(fontSize: 16),
                ),
              ),
              if (form.contactPersons.length < form.maxContactPersons)
                TextButton(
                  onPressed: cubit.addContactPerson,
                  child: const Text('+ Add contact'),
                ),
            ],
          ).animate().slideIn(90),
          for (var i = 0; i < form.contactPersons.length; i++)
            _ContactPersonFields(
              index: i,
              contact: form.contactPersons[i],
              canRemove: i > 0,
            ).animate().slideIn(95),
        ],
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
            onFilePicked: (file) => cubit.pickDocument(type, file),
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

  void _update({
    String? organisationName,
    String? industryType,
    String? address,
    String? socialDevelopmentNumber,
  }) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(
            organisationName: organisationName ?? form.organisationName,
            industryType: industryType ?? form.industryType,
            address: address ?? form.address,
            socialDevelopmentNumber:
                socialDevelopmentNumber ?? form.socialDevelopmentNumber,
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
    if (form.requiresOrganisationDetails) {
      if (form.address == null || form.address!.trim().isEmpty) {
        context.snackBarError('Please provide the address.');
        return;
      }
      if (form.requiresSocialDevelopmentNumber &&
          (form.socialDevelopmentNumber == null ||
              form.socialDevelopmentNumber!.trim().isEmpty)) {
        context.snackBarError('Please provide the Social Development Number.');
        return;
      }
      if (!form.hasValidContactPersons) {
        context.snackBarError(
          'Please provide at least one contact person (email and phone).',
        );
        return;
      }
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

class _ContactPersonFields extends StatelessWidget {
  const _ContactPersonFields({
    required this.index,
    required this.contact,
    required this.canRemove,
  });

  final int index;
  final ContactPerson contact;
  final bool canRemove;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrganisationCubit>();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Contact ${index + 1}',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              if (canRemove)
                InkWell(
                  onTap: () => cubit.removeContactPerson(index),
                  child: Icon(Icons.close, size: 16, color: Colors.grey.shade600),
                ),
            ],
          ),
          EESUpTextFormField(
            initialValue: contact.email,
            label: 'Email',
            hintText: 'contact@example.com',
            type: TextInputType.emailAddress,
            isRequired: true,
            onChanged: (value) =>
                cubit.updateContactPerson(index, email: value),
          ),
          EESUpTextFormField(
            initialValue: contact.phone,
            label: 'Phone Number',
            hintText: '0821234567',
            type: TextInputType.phone,
            isRequired: true,
            onChanged: (value) =>
                cubit.updateContactPerson(index, phone: value),
          ),
        ],
      ),
    );
  }
}
