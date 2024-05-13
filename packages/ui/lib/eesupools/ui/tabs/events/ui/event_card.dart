import 'dart:math';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_event.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:ui/eesupools/ui/tabs/chats/ui/widgets/animated_reaction_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.pool,
  });
  final EESUpool pool;
  final EESUpoolEvent event;

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  bool isAttending(String? id) {
    return event.attendees?.any((element) => element.memberId == id) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    bool isAttending = this.isAttending(pool.memberId);

    return InkWell(
      onTap: () {
        //showCreateEESUpoolEvent(context, event: event);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300, width: .8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            left: 10,
            top: 10,
            bottom: 10,
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(.2),
            child: Icon(IconlyLight.calendar, color: getRandomColor()),
          ),
          title: Text(event.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormatter.yetAnotherDateFormat2(event.startAt),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 45),
                child: Icon(IconlyLight.arrowDown3, size: 15),
              ),
              Text(
                DateFormatter.yetAnotherDateFormat2(event.startAt),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(thickness: .3),
              Row(
                children: [
                  const Icon(
                    IconlyLight.user3,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${event.attendees?.length ?? 0} members',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          trailing: AnimatedReactionButton(
            child: Icon(
              isAttending
                  ? BootstrapIcons.person_dash
                  : BootstrapIcons.person_add,
              size: 26,
              color: isAttending ? Colors.red : context.colorScheme.primary,
            ),
            onTap: () async {
              // if (membershipId == null) return;

              // ref.read(loadingStateProvider.notifier).toggle();
              // final repo = ref.read(eesupoolRepoProvider);
              // final result = !isAttending
              //     ? await repo.subEvent(event.id, membershipId)
              //     : await repo.unsubEvent(event.id, membershipId);
              // ref.read(loadingStateProvider.notifier).toggle();

              // result.fold((l) {
              //   showSnackBar(
              //     context: context,
              //     message: l.message,
              //     type: SnackBarType.error,
              //   );
              // }, (r) {
              //   ref.invalidate(eesupoolEventsProvider);
              // });
            },
          ),
        ),
      ),
    );
  }
}
