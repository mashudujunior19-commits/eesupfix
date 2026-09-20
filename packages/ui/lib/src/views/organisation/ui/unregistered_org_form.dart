import 'package:data/organisation/models/organisation_contact_method.dart';
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
import 'package:ui/src/views/organisation/ui/widgets/organisation_address_field.dart';

class UnregisteredOrgForm extends StatefulWidget {
  const UnregisteredOrgForm({
    super.key,
    required this.form,
    required this.tabController,
  });

  final OrganisationForm form;
  final TabController tabController;

  @override
  State<UnregisteredOrgForm> createState() => _UnregisteredOrgFormState();
}

class _UnregisteredOrgFormState extends State<UnregisteredOrgForm> {
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
        OrganisationAddressField(
          address: form.address,
          onAddressSelected: (address) {
            context.read<OrganisationCubit>().updateForm(
                  form.copyWith(address: address, addressId: address?.id),
                );
          },
        ).animate().slideIn(50),
        EESUpTextFormField(
          initialValue: form.contactPerson1,
          label: 'Contact Person 1',
          isRequired: true,
          onChanged: (value) =>
              _update(contactPerson1: value.isEmpty ? null : value),
        ).animate().slideIn(100),
        Text(
          'Preferred contact method',
          style: context.textTheme.labelMedium?.copyWith(fontSize: 14),
        ).animate().slideIn(150),
        5.sH,
        Wrap(
          spacing: 10,
          children: OrganisationContactMethod.values.map((method) {
            final isSelected = form.contactMethod == method;
            return ChoiceChip(
              label: Text(method.toString()),
              selected: isSelected,
              onSelected: (_) {
                context.read<OrganisationCubit>().updateForm(
                      form.copyWith(contactMethod: method),
                    );
              },
            );
          }).toList(),
        ).animate().slideIn(200),
        10.sH,
        EESUpTextFormField(
          initialValue: form.contactValue,
          label: _contactValueLabel(form.contactMethod),
          type: form.contactMethod == OrganisationContactMethod.email
              ? TextInputType.emailAddress
              : TextInputType.phone,
          isRequired: true,
          onChanged: (value) =>
              _update(contactValue: value.isEmpty ? null : value),
        ).animate().slideIn(250),
        EESUpTextFormField(
          initialValue: form.industryType,
          label: 'Industry Type',
          isRequired: true,
          onChanged: (value) =>
              _update(industryType: value.isEmpty ? null : value),
        ).animate().slideIn(300),
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

  String _contactValueLabel(OrganisationContactMethod? method) {
    switch (method) {
      case OrganisationContactMethod.email:
        return 'Email Address';
      case OrganisationContactMethod.phoneNumber:
        return 'Phone Number';
      case OrganisationContactMethod.cellNumber:
        return 'Cell Number';
      case null:
        return 'Contact Value';
    }
  }

  void _update({
    String? name,
    String? contactPerson1,
    String? contactValue,
    String? industryType,
  }) {
    context.read<OrganisationCubit>().updateForm(
          form.copyWith(
            name: name ?? form.name,
            contactPerson1: contactPerson1 ?? form.contactPerson1,
            contactValue: contactValue ?? form.contactValue,
            industryType: industryType ?? form.industryType,
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
    if (form.contactPerson1 == null || form.contactPerson1!.trim().isEmpty) {
      context.snackBarError('Please provide a contact person.');
      return;
    }
    if (form.contactMethod == null) {
      context.snackBarError('Please choose a preferred contact method.');
      return;
    }
    if (!form.isValidContactValue()) {
      context.snackBarError(
        form.contactMethod == OrganisationContactMethod.email
            ? 'Please provide a valid email address.'
            : 'Please provide a valid South African phone number.',
      );
      return;
    }
    if (form.industryType == null || form.industryType!.trim().isEmpty) {
      context.snackBarError('Please provide the industry type.');
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
