import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/eesupools/ui/eesupool_type_view.dart';
import 'package:flutter/material.dart';

class MyKasiTab extends StatelessWidget {
  const MyKasiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        50.sH,
        Container(
          padding: const EdgeInsets.only(left: 15, top: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: const Row(children: [Text('MyKasi')]),
        ),
        const Expanded(child: EESUpoolsTypeView(type: EESUpoolType.kasi)),
      ],
    );
  }
}
