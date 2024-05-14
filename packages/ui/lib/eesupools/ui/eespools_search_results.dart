import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:flutter/widgets.dart';


@RoutePage()
class EESUpoolSearchResultScreen extends StatelessWidget {
  const EESUpoolSearchResultScreen({
    super.key,
    required this.text,
    required this.type,
  });
  final EESUpoolType type;
  final String text;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
