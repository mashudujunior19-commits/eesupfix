import 'package:data/get_involved/models/contact_person.dart';
import 'package:data/get_involved/models/contact_person_role.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_dropdown_form_field.dart';
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
          label: form.isNPO ? 'Name of Organisation' : 'Name of Business',
          hintText:
              form.isNPO ? "Enter your organisation's name" : 'Enter your business name',
          isRequired: true,
          onChanged: (value) => _updateOrganisationName(value),
        ).animate().slideIn(0),
        EESUpDropdownFormField<String>(
          value: industryTypeOptions.contains(form.industryType)
              ? form.industryType
              : null,
          label: 'Industry type',
          hintText: 'Select an industry type',
          isRequired: true,
          items: industryTypeOptions,
          itemLabel: (value) => value,
          onChanged: (value) => _updateIndustryType(value ?? ''),
        ).animate().slideIn(50),
        if (form.requiresOrganisationDetails) ...[
          EESUpTextFormField(
            initialValue: form.address,
            label: 'Address',
            hintText: form.isNPO
                ? "Enter the organisation's physical address"
                : "Enter the business's physical address",
            isRequired: true,
            onChanged: (value) => _updateAddress(value),
          ).animate().slideIn(75),
          if (form.requiresProvince)
            EESUpDropdownFormField<String>(
              value: provinceOptions.contains(form.province)
                  ? form.province
                  : null,
              label: 'Province',
              hintText: 'Select a province',
              items: provinceOptions,
              itemLabel: (value) => value,
              onChanged: (value) => _updateProvince(value ?? ''),
            ).animate().slideIn(80),
          if (form.requiresSocialDevelopmentNumber)
            EESUpTextFormField(
              initialValue: form.socialDevelopmentNumber,
              label: 'Social Development Number',
              isOptional: true,
              hintText: 'NPO registration number (Dept. of Social '
                  'Development), if registered with the DSD',
              onChanged: (value) => _updateSocialDevelopmentNumber(value),
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
            wouldBeRequiredIfKasiLift: form.isNPO &&
                !form.isKasilift &&
                form.baseRequiredDocumentTypes.contains(type),
            allowedExtensions: docSpecs[type]!.extensions,
            pickedFile: form.pickedDocuments[type],
            isUploading: form.uploadingDocuments.contains(type),
            isUploaded: form.uploadedDocumentPaths[type] != null,
            onFilePicked: (file) => cubit.pickDocument(type, file),
          ).animate().slideIn(150),
        if (form.isNPO) ...[
          20.sH,
          _KasiliftOptIn(form: form),
        ],
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

  void _updateOrganisationName(String value) {
    context.read<OrganisationCubit>().updateForm(
          form.updateDetails(
            organisationName: value.isEmpty ? null : value,
          ),
        );
  }

  void _updateIndustryType(String value) {
    context.read<OrganisationCubit>().updateForm(
          form.updateDetails(industryType: value.isEmpty ? null : value),
        );
  }

  void _updateAddress(String value) {
    context.read<OrganisationCubit>().updateForm(
          form.updateDetails(address: value.isEmpty ? null : value),
        );
  }

  void _updateProvince(String value) {
    context.read<OrganisationCubit>().updateForm(
          form.updateDetails(province: value.isEmpty ? null : value),
        );
  }

  void _updateSocialDevelopmentNumber(String value) {
    context.read<OrganisationCubit>().updateForm(
          form.updateDetails(
            socialDevelopmentNumber: value.isEmpty ? null : value,
          ),
        );
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (form.organisationName == null ||
        form.organisationName!.trim().isEmpty) {
      context.snackBarError(
        form.isNPO
            ? 'Please provide the organisation name.'
            : 'Please provide the business name.',
      );
      return;
    }
    if (form.industryType == null || form.industryType!.trim().isEmpty) {
      context.snackBarError('Please select an industry type.');
      return;
    }
    if (form.requiresOrganisationDetails) {
      if (form.address == null || form.address!.trim().isEmpty) {
        context.snackBarError('Please provide the address.');
        return;
      }
      if (!form.hasValidContactPersons) {
        context.snackBarError(
          'Please provide at least one contact person '
          '(name, email and phone).',
        );
        return;
      }
    }
    if (!form.hasAllRequiredDocuments) {
      context.snackBarError('Please upload all required documents.');
      return;
    }
    if (!form.hasValidKasiliftDetails) {
      context.snackBarError('Please tell us a bit about your KasiLift '
          'organisation in "About Us".');
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

class _KasiliftOptIn extends StatelessWidget {
  const _KasiliftOptIn({required this.form});

  final OrganisationForm form;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrganisationCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => cubit.updateForm(
            form.copyWith(isKasilift: !form.isKasilift),
          ),
          child: Row(
            children: [
              Checkbox(
                value: form.isKasilift,
                onChanged: (value) => cubit.updateForm(
                  form.copyWith(isKasilift: value ?? false),
                ),
              ),
              Expanded(
                child: Text(
                  'Register as KasiLift Organisation',
                  style: context.textTheme.labelMedium?.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        if (form.isKasilift) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4),
            child: Text(
              'KasiLift organisations participate in the Social '
              'Wallet funding ecosystem.',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          EESUpTextFormField(
            initialValue: form.aboutUs,
            label: 'About Us',
            hintText: 'Tell us about your organisation and its mission',
            isRequired: true,
            maxLines: 4,
            onChanged: (value) => cubit.updateForm(
              form.updateDetails(aboutUs: value.isEmpty ? null : value),
            ),
          ),
        ],
      ],
    );
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
            initialValue: contact.name,
            label: 'Name',
            hintText: 'Full name',
            isRequired: true,
            onChanged: (value) => cubit.updateContactPerson(
              index,
              name: value.isEmpty ? null : value,
              email: contact.email,
              phone: contact.phone,
              role: contact.role,
            ),
          ),
          EESUpTextFormField(
            initialValue: contact.email,
            label: 'Email',
            hintText: 'contact@example.com',
            type: TextInputType.emailAddress,
            isRequired: true,
            onChanged: (value) => cubit.updateContactPerson(
              index,
              name: contact.name,
              email: value,
              phone: contact.phone,
              role: contact.role,
            ),
          ),
          EESUpTextFormField(
            initialValue: contact.phone,
            label: 'Phone Number',
            hintText: '0821234567',
            type: TextInputType.phone,
            isRequired: true,
            onChanged: (value) => cubit.updateContactPerson(
              index,
              name: contact.name,
              email: contact.email,
              phone: value,
              role: contact.role,
            ),
          ),
          EESUpDropdownFormField<ContactPersonRole>(
            value: contact.role,
            label: 'Role',
            hintText: 'Select a role',
            items: ContactPersonRole.values,
            itemLabel: (role) => role.label,
            onChanged: (role) => cubit.updateContactPerson(
              index,
              name: contact.name,
              email: contact.email,
              phone: contact.phone,
              role: role,
            ),
          ),
        ],
      ),
    );
  }
}
