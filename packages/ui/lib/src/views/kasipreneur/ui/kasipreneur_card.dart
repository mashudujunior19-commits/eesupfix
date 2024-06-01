import 'package:auto_route/auto_route.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/kasipreneur/bloc/kasipreneur_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class KasipreneurCard extends StatelessWidget {
  const KasipreneurCard({super.key, required this.eesupreneur});
  final EESUpreneur eesupreneur;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(KasipreneurRoute(eesupreneur: eesupreneur))
            .then((value) {
          context.read<KasipreneurBloc>().add(KasipreneurFetched());
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 15),
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
            radius: 25,
            backgroundColor: context.colorScheme.primary.withOpacity(.15),
            child: Image.asset(
              "assets/images/pin.png",
              height: 30,
              color: context.colorScheme.primary,
            ),
          ),
          title: Text(eesupreneur.name, style: context.textTheme.labelMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Open',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            IconlyLight.arrowRight2,
            size: 20,
          ),
        ),
      ),
    );
  }
}
