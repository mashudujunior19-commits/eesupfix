import 'package:data_sources/partners/models/partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key, required this.partner});
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return InkWell(
      onTap: () {
        // context.push(PartnerAppScreen.route, extra: partner);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(.1),
            child: Icon(
              IconlyLight.work,
              color: colorScheme.primary,
            ),
          ),
          title: Text(partner.title),
          subtitle: Text(
            partner.description,
            style: textTheme.labelSmall,
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            color: colorScheme.primary,
            size: 17,
          ),
        ),
      ),
    );
  }
}
