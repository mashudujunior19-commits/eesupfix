import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class OrganisationSuccessScreen extends StatelessWidget {
  const OrganisationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 70),
        20.sH,
        Text(
          'Application submitted!',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        10.sH,
        Text(
          'Your organisation registration is now pending review. '
          "We'll notify you once it has been reviewed.",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: ElevatedButton(
            child: const Text('Done'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
      ],
    );
  }
}
