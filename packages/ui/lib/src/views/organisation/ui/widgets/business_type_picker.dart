import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/organisation/cubit/commercial_verticals.dart';

/// A field that opens a sheet of the [vertical]'s business types, split into
/// formal businesses and "Likely Informal and Township Businesses".
class BusinessTypePicker extends StatelessWidget {
  const BusinessTypePicker({
    super.key,
    required this.vertical,
    required this.value,
    required this.onChanged,
  });

  final CommercialVertical? vertical;
  final String? value;
  final ValueChanged<String> onChanged;

  Future<void> _open(BuildContext context) async {
    final v = vertical;
    if (v == null) return;
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: .75,
        maxChildSize: .95,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.only(bottom: 30),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                v.name,
                style: context.textTheme.labelMedium?.copyWith(fontSize: 17),
              ),
            ),
            if (v.formal.isNotEmpty) ...[
              const _SectionHeader('Formal businesses'),
              for (final b in v.formal) _BusinessTile(b, selected: value),
            ],
            if (v.informal.isNotEmpty) ...[
              const _SectionHeader(informalBusinessesLabel),
              for (final b in v.informal) _BusinessTile(b, selected: value),
            ],
          ],
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = vertical != null;
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Business type',
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' *',
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: 15,
                  color: context.colorScheme.error,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: enabled ? () => _open(context) : null,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(.03),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: .5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value ??
                          (enabled
                              ? 'Select your type of business'
                              : 'Select an industry first'),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: value == null ? Colors.grey.shade500 : null,
                      ),
                    ),
                  ),
                  const Icon(IconlyLight.arrowDown2, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: context.colorScheme.primary.withOpacity(.06),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BusinessTile extends StatelessWidget {
  const _BusinessTile(this.business, {required this.selected});
  final BusinessType business;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    final isSelected = business.name == selected;
    return ListTile(
      onTap: () => Navigator.of(context).pop(business.name),
      title: Text(business.name, style: context.textTheme.labelMedium),
      subtitle: Text(
        [
          if (business.examples != null) business.examples!,
          'Buys: ${business.purchases}',
        ].join('\n'),
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.grey.shade600,
        ),
      ),
      isThreeLine: business.examples != null,
      trailing: isSelected
          ? Icon(Icons.check_circle, color: context.colorScheme.primary)
          : null,
    );
  }
}
