import 'package:flutter/widgets.dart';

extension SizedBoxGapExt on num {
  SizedBox get sH => SizedBox(height: toDouble());
  SizedBox get sW => SizedBox(width: toDouble());
}