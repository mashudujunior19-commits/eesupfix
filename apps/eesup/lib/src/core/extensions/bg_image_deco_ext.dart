import 'package:flutter/material.dart';

extension BgImageDecoExt on BuildContext {
  BoxDecoration get bgImage => const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/background.png',
          ),
        ),
      );
}
