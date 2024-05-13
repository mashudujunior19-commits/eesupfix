import 'package:auto_route/auto_route.dart';
import 'package:data/partners/models/partner.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key, required this.partner});
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(PartnerAppRoute(partner: partner));
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
            backgroundColor: context.colorScheme.primary.withOpacity(.1),
            child: Icon(
              IconlyLight.work,
              color: context.colorScheme.primary,
            ),
          ),
          title: Text(partner.title),
          subtitle: Text(
            partner.description,
            style: context.textTheme.labelSmall,
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            color: context.colorScheme.primary,
            size: 17,
          ),
        ),
      ),
    );
  }
}
