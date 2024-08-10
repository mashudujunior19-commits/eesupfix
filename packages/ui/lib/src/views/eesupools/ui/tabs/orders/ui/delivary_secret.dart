import 'package:flutter/material.dart';

class DelivarySecret extends StatefulWidget {
  const DelivarySecret({super.key, required this.secret});
  final String secret;

  @override
  State<DelivarySecret> createState() => _DelivarySecretState();
}

class _DelivarySecretState extends State<DelivarySecret> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: !isVisible ? 5 : 0),
          child: Text(isVisible ? widget.secret : '*****'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: Text(!isVisible ? 'Show' : 'Hide'),
        )
      ],
    );
  }
}
