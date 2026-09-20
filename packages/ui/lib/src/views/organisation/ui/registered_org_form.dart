import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/views/organisation/cubit/organisation_cubit.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';
import 'package:ui/src/views/organisation/ui/widgets/organisation_address_field.dart';

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
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 60),
      children: [
        EESUpTextFormField(
          initialValue: form.name,
          label: 'Name',
          isRequired: true,
          onChanged: (value) => _update(name: value.isEmpty ? null : value),
        ).animate().slideIn(0),
        EESUpTextFormField(
          initialValue: form.surname,
          label: 'Surname',
          isRequired: true,
          onChanged: (value) =>
              _update(surname: value.isEmpty ? null : value),
        ).animate().slideIn(50),
        OrganisationAddressField(
          address: form.address,
          onAddressSelected: (address) {
            context.read<OrganisationCubit>().updateForm(
                  form.copyWith(address: address, addressId: address?.id),
                );
          },
        ).animate().slideIn(100),
        EESUpTextFormField(
          initialValue: form.contactPerson1,
          label: 'Contact Person 1',
          isRequired: true,
          onChanged: (value) =>
              _update(contactPerson1: value.isEmpty ? null : value),
        ).animate().slideIn(150),
        EESUpTextFormField(
          initialValue: form.contactPerson2,
          label: 'Contact Person 2',
          onChanged: (value) =>
              _update(contactPerson2: value.isEmpty ? null : value),
        ).animate().slideIn(200),
        EESUpTextFormField(
          initialValue: form.contactPerson3,
          label: 'Contact Person 3',
          onChanged: (value) =>
              _update(contactPerson3: value.isEmpty ? null : value),
        ).animate().slideIn(250),
        EESUpTextFormField(
          initialValue: form.companyRegistrationNumber,
          label: 'Company Registration Number',
          hintText: 'e.g. 2021/123456/07',
          isRequired: true,
          onChanged: (value) => _update(
            companyRegistrationNumber: value.isEmpty ? null : value,
          ),
        ).animate().slideIn(300),
        EESUpTextFormField(
          initialValue: form.vatNumber,
          label: 'VAT Number',
          hintText: 'Optional',
          onChanged: (value) => _update(vatNumber: value.isEmpty ? null : value),
        ).animate().slideIn(350),
        EESUpTextFormField(
          initialValue: form.industryType,
          label: 'Industry Type',
          isRequired: true,
          onChanged: (value) =>
              _update(industryType: value.isEmpty ? null : value),
        ).animate().slideIn(400),
        if (form.isNPO)
          EESUpTextFormField(
            initialValue: form.pboNumber,
            label: 'PBO Number',
            isRequired: true,
            onChanged: (value) =>
                _update(pboNumber: value.isEmpty ? null : value),
          ).animate().slideIn(450),
        if (form.isNPO)
          EESUpTextFormField(
            initialValue: form.socialDevelopmentNumber,
            label: 'Social Development Number',
            isRequired: true,
            onChanged: (value) => _update(
              socialDevelopmentNumber: value.isEmpty ? null : value,
            ),
          ).animate().slideIn(500),
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
    String? name,
    String? surname,
    String? contactPerson1,
    String? contactPerson2,
    String? contactPerson3,
    String? companyRegistrationNumber,
    String? vatNumber,
    String? industryType,
    String? pboNumber,
    String? socialDevelopmentNumber,
  }) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(
            name: name ?? form.name,
            surname: surname ?? form.surname,
            contactPerson1: contactPerson1 ?? form.contactPerson1,
            contactPerson2: contactPerson2 ?? form.contactPerson2,
            contactPerson3: contactPerson3 ?? form.contactPerson3,
            companyRegistrationNumber:
                companyRegistrationNumber ?? form.companyRegistrationNumber,
            vatNumber: vatNumber ?? form.vatNumber,
            industryType: industryType ?? form.industryType,
            pboNumber: pboNumber ?? form.pboNumber,
            socialDevelopmentNumber:
                socialDevelopmentNumber ?? form.socialDevelopmentNumber,
          ),
        );
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (form.name == null || form.name!.trim().isEmpty) {
      context.snackBarError('Please provide the organisation name.');
      return;
    }
    if (form.surname == null || form.surname!.trim().isEmpty) {
      context.snackBarError('Please provide a surname.');
      return;
    }
    if (form.contactPerson1 == null || form.contactPerson1!.trim().isEmpty) {
      context.snackBarError('Please provide at least one contact person.');
      return;
    }
    if (!form.isValidCompanyRegistrationNumber()) {
      context.snackBarError(
        'Please provide a valid company registration number '
        '(e.g. 2021/123456/07).',
      );
      return;
    }
    if (!form.isValidVATNumber()) {
      context.snackBarError('Please provide a valid VAT number.');
      return;
    }
    if (form.industryType == null || form.industryType!.trim().isEmpty) {
      context.snackBarError('Please provide the industry type.');
      return;
    }
    if (form.isNPO && !form.isValidPBONumber()) {
      context.snackBarError('Please provide a valid PBO number.');
      return;
    }
    if (form.isNPO &&
        (form.socialDevelopmentNumber == null ||
            form.socialDevelopmentNumber!.trim().isEmpty)) {
      context.snackBarError('Please provide the Social Development Number.');
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
