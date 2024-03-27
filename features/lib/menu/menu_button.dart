import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    this.isVisible = true,
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final bool isVisible;
  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.sH,
              Icon(icon, size: 32),
              5.sH,
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelMedium?.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
