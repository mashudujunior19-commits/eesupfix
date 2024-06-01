import 'package:data/orders/models/order.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.status,
    required this.onChanged,
    required this.label,
    required this.icon,
    this.isLast = false,
    this.canEdit = false,
    this.date,
    required this.isVisible,
    this.onTap,
  });
  final bool isVisible;
  final String label;
  final IconData icon;
  final bool isLast;
  final OrderStatus status;
  final DateTime? date;
  final bool canEdit;
  final void Function()? onTap;
  final void Function(OrderStatus status) onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: onTap ?? (canEdit ? () => onChanged(status) : null),
          contentPadding: const EdgeInsets.all(0),
          trailing: canEdit
              ? Checkbox(
                  value: date != null,
                  onChanged: (v) {
                    if (v == true) {
                      onChanged(status);
                    } else {
                      onChanged(OrderStatus.placed);
                    }
                  },
                )
              : null,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: date != null
                  ? colorScheme.primary
                  : colorScheme.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          subtitle: Row(
            children: [
              const Icon(IconlyLight.timeCircle, size: 11, color: Colors.black),
              5.sW,
              Text(
                date == null
                    ? '~~~'
                    : DateFormatter.yetAnotherDateFormat2(date!),
                style: textTheme.labelSmall?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
        if (!isLast)
          Container(
            margin: const EdgeInsets.only(left: 19),
            height: 20,
            width: 2,
            color: date != null
                ? colorScheme.primary
                : colorScheme.primary.withOpacity(.1),
          ),
      ],
    );
  }
}
