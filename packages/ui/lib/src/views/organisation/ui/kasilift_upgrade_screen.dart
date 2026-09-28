import 'package:auto_route/auto_route.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_dropdown_form_field.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:ui/src/views/organisation/cubit/kasilift_upgrade_cubit.dart';
import 'package:ui/src/views/organisation/cubit/kasilift_upgrade_state.dart';
import 'package:ui/src/views/organisation/ui/widgets/document_specs.dart';
import 'package:ui/src/views/organisation/ui/widgets/document_upload_field.dart';

/// Lets a user opt an existing (already submitted) organisation/business
/// registration into KasiLift, without re-running the whole registration
/// wizard -- reached from the "Get Involved" tab.
@RoutePage()
class KasiliftUpgradeScreen extends StatefulWidget {
  const KasiliftUpgradeScreen({super.key});

  @override
  State<KasiliftUpgradeScreen> createState() => _KasiliftUpgradeScreenState();
}

class _KasiliftUpgradeScreenState extends State<KasiliftUpgradeScreen> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          KasiliftUpgradeCubit(context.read<GetInvolvedRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Upgrade to KasiLift')),
        body: BlocConsumer<KasiliftUpgradeCubit, KasiliftUpgradeState>(
          listener: (context, state) {
            if (state.status == KasiliftUpgradeStatus.success) {
              context.snackBarSuccess(
                'Your organisation is now registered for KasiLift.',
              );
              Navigator.of(context).pop(true);
            } else if (state.status == KasiliftUpgradeStatus.failed) {
              context.snackBarError(
                state.errorMessage ?? 'Something went wrong.',
              );
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case KasiliftUpgradeStatus.loading:
                return const FullScreenLoadingShimmer();
              case KasiliftUpgradeStatus.noEligibleSubmissions:
                return FullScreenError(
                  isError: false,
                  exception: EESUpException(
                    message: "You don't have an existing organisation or "
                        'business registration to upgrade yet. Please '
                        'register one first, then come back here to opt '
                        'into KasiLift.',
                  ),
                );
              case KasiliftUpgradeStatus.failed
                  when state.eligibleSubmissions.isEmpty:
                return FullScreenError(
                  exception: EESUpException(
                    message: state.errorMessage ??
                        'Something went wrong while loading your '
                            'registrations.',
                  ),
                );
              default:
                return _UpgradeForm(
                  state: state,
                  isSubmitting: _isSubmitting,
                  onSubmit: () => _handleSubmit(context, state),
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    KasiliftUpgradeState state,
  ) async {
    if (_isSubmitting) return;
    if (!state.hasAboutUs) {
      context.snackBarError('Please tell us a bit about your organisation.');
      return;
    }
    if (!state.hasAllRequiredDocuments) {
      context.snackBarError('Please upload all required documents.');
      return;
    }
    setState(() => _isSubmitting = true);
    await context.read<KasiliftUpgradeCubit>().submit();
    if (!mounted) return;
    setState(() => _isSubmitting = false);
  }
}

class _UpgradeForm extends StatelessWidget {
  const _UpgradeForm({
    required this.state,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final KasiliftUpgradeState state;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KasiliftUpgradeCubit>();
    final selected = state.selected;
    final documentTypes = [
      ...state.requiredDocumentTypes,
      ...state.optionalDocumentTypes,
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'KasiLift organisations participate in the Social Wallet '
          'funding ecosystem.',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        if (state.eligibleSubmissions.length > 1)
          EESUpDropdownFormField<String>(
            value: selected?.id,
            label: 'Which registration would you like to upgrade?',
            items: state.eligibleSubmissions
                .map((s) => s.id!)
                .toList(),
            itemLabel: (id) => state.eligibleSubmissions
                .firstWhere((s) => s.id == id)
                .organisationName,
            onChanged: (id) {
              if (id == null) return;
              cubit.selectSubmission(
                state.eligibleSubmissions.firstWhere((s) => s.id == id),
              );
            },
          )
        else if (selected != null) ...[
          10.sH,
          Text(
            selected.organisationName,
            style: context.textTheme.labelMedium?.copyWith(fontSize: 16),
          ),
        ],
        EESUpTextFormField(
          initialValue: state.aboutUs,
          label: 'About Us',
          hintText: 'Tell us about your organisation and its mission',
          isRequired: true,
          maxLines: 4,
          onChanged: cubit.updateAboutUs,
        ),
        20.sH,
        if (documentTypes.isNotEmpty)
          Text(
            'Upload Documents',
            style: context.textTheme.labelMedium?.copyWith(fontSize: 16),
          ),
        for (final type in documentTypes)
          DocumentUploadField(
            label: docSpecs[type]!.label,
            hint: docSpecs[type]!.hint,
            isRequired: state.requiredDocumentTypes.contains(type),
            allowedExtensions: docSpecs[type]!.extensions,
            pickedFile: state.pickedDocuments[type],
            isUploading: state.uploadingDocuments.contains(type),
            isUploaded: false,
            onFilePicked: (file) => cubit.pickDocument(type, file),
          ),
        30.sH,
        ElevatedButton(
          onPressed: isSubmitting ? null : onSubmit,
          child: isSubmitting
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
}
