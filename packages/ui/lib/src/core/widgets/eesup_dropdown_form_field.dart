import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';

/// A labelled dropdown field styled to match [EESUpTextFormField].
class EESUpDropdownFormField<T> extends StatelessWidget {
  const EESUpDropdownFormField({
    super.key,
    this.label,
    this.hintText,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.margin,
    this.isRequired = false,
  });

  final String? label;
  final String? hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final EdgeInsets? margin;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Row(
              children: [
                Text(
                  label!,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isRequired)
                  Text(
                    ' *',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.error,
                    ),
                  ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(.03),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300, width: .5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<T>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 5),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.withOpacity(.8),
                    fontSize: 13.5,
                  ),
                ),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
                items: items
                    .map(
                      (item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          itemLabel(item),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
