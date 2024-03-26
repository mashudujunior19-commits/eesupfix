import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data_sources/eesupreneur/models/eesupreneur.dart';

// final _userEESUpreneursProvider =
//     FutureProvider.autoDispose<List<EESUpreneur>>((ref) async {
//   final repo = ref.watch(eesupreneurRepoProvider);
//   final result = await repo.getUsertEESUpreneurs();
//   return result.fold((l) {
//     throw l;
//   }, (r) => r);
// });

@RoutePage()
class KasipreneurScreen extends StatelessWidget {
  const KasipreneurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EESUpreneur> shops = [];
    return ListView.builder(
      itemCount: shops.length,
      itemBuilder: (context, index) {
        return KasipreneurCard(eesupreneur: shops[index])
            .animate()
            .slideIn(50.00 * index);
      },
    );
  }
}

class KasipreneurCard extends StatelessWidget {
  const KasipreneurCard({super.key, required this.eesupreneur});
  final EESUpreneur eesupreneur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return InkWell(
      onTap: () {
        // setEESUpreneur(ref, eesupreneur);
        // context.push(EESUpreneurViewScreen.route).whenComplete(() {
        //   resetEESUpreneur(ref);
        // });
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
            backgroundColor: colorScheme.primary.withOpacity(.15),
            child: Image.asset(
              "assets/images/pin.png",
              height: 30,
              color: colorScheme.primary,
            ),
          ),
          title: Text(eesupreneur.name, style: textTheme.labelMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Open',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              // Text(
              //   '10 new orders',
              //   style: textTheme.labelSmall?.copyWith(
              //     color: colorScheme.primary,
              //   ),
              // ),
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
