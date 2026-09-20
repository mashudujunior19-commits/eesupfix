import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class OrganisationOptionTile extends StatelessWidget {
  const OrganisationOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withOpacity(.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : Colors.grey.shade300,
            width: isSelected ? 1.2 : .5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  5.sH,
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ? context.colorScheme.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
