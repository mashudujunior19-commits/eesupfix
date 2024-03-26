import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferalCodeTile extends StatelessWidget {
  const ReferalCodeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
        bottom: 10,
      ),
      padding: const EdgeInsets.only(left: 10, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SelectableText('Code ${10000}'),
            Container(
              // width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: 21000.toString(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content: const Text("Copied to clipboard"),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
