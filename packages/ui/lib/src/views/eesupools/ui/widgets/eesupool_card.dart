import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/views/eesupools/bloc/eesupool_type_bloc.dart';

class EESUpoolCard extends StatelessWidget {
  const EESUpoolCard({
    super.key,
    required this.eesupool,
    this.onPoolTap,
    this.margin,
  });
  final EESUpool eesupool;
  final void Function(EESUpool pool)? onPoolTap;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final numMembers = eesupool.numMembers ?? 0;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPoolTap != null
          ? () {
              //onPoolTap!(eesupool);
            }
          : () {
              context.router
                  .push(EESUpoolViewRoute(pool: eesupool))
                  .whenComplete(() {
                context.read<EESUpoolTypeViewBloc>().add(
                      EESUpoolsTypeViewFetched(eesupool.type),
                    );
              });
            },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 15, left: 15, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: context.colorScheme.primary.withOpacity(.1),
            child: Image.asset("assets/images/kasi.png", width: 27),
          ),
          title: Text(
            eesupool.name,
            style: context.textTheme.labelMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eesupool.level != null)
                Text(
                  eesupool.level.toString(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.secondary,
                    fontSize: 12,
                  ),
                ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (numMembers > 0)
                    Row(
                      children: [
                        Icon(
                          IconlyLight.user3,
                          size: 16,
                          color: context.colorScheme.primary,
                        ),
                        Text(
                          '  ${eesupool.numMembers}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  Container(
                    width: 1,
                    height: 13,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    color: Colors.grey,
                  ),
                  Text(
                    'Code: ${eesupool.code.toString()}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12.5),
                  ),
                ],
              ),
              // if (unseenMessages > 0)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 3),
              //     child: Row(
              //       children: [
              //         Icon(
              //           IconlyLight.message,
              //           size: 13,
              //           color: context.colorScheme.primary,
              //         ),
              //         const SizedBox(width: 5),
              //         Text(
              //           '${eesupool.unseenMessages} New Messages',
              //           style: context.textTheme.bodySmall?.copyWith(
              //             color: context.colorScheme.primary,
              //             fontSize: 13,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ).animate().shakeX(
              //         delay: 1000.ms,
              //         duration: 1000.ms,
              //         // rotation: .23,
              //         curve: Curves.easeInCubic,
              //       ),
            ],
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            color: Colors.grey.shade400,
            size: 17,
          ),
        ),
      ),
    );
  }
}
