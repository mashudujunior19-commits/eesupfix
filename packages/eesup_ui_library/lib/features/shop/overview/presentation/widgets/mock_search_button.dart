import 'package:eesup_ui_library/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MockSearchButton extends StatelessWidget {
  const MockSearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 45,
        margin: const EdgeInsets.only(right: 15, left: 15, top: 60),
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(IconlyLight.search, color: Colors.black, size: 20),
                  const SizedBox(width: 15),
                  Text(
                    'Search for products',
                    style:context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              // const ScanQrCodeButton(margin: EdgeInsets.only(left: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
