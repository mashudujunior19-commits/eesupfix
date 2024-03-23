import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MenuButtonTile extends StatelessWidget {
  const MenuButtonTile({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
    this.counter,
    this.isVisible = true,
    this.showBorder = true,
    this.imagePath,
    this.size,
  });
  final String? imagePath;
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final int? counter;
  final bool isVisible;
  final bool showBorder;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Image.asset(
                  imagePath!,
                  width: size ?? 22,
                  height: size ?? 21,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: colorScheme.secondary,
                            width: .1,
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(IconlyLight.arrowRight2, size: 17)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
