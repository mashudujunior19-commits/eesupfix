import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/eesupools/ui/tabs/events/bloc/events_list_bloc.dart';
import 'package:ui/eesupools/ui/tabs/events/ui/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key, required this.pool});
  final EESUpool pool;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsListBloc(context.read<EESUpoolRepository>())
        ..add(EventsFetched(pool.eesupoolId!, 500)),
      child: BlocBuilder<EventsListBloc, EventsListState>(
        builder: (context, state) {
          if (state is EventsListLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is EventsListError) {
            return FullScreenError(exception: state.error);
          } else if (state is EventsListLoaded) {
            final events = state.events;
            if (events.isEmpty) {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: 'There are no events yet.',
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: ListView.separated(
                padding: const EdgeInsets.only(top: 10, bottom: 200),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventCard(event: event, pool: pool)
                      .animate()
                      .fadeIn()
                      .slideIn(index * 50);
                },
                separatorBuilder: (context, index) => Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 60),
                      height: 25,
                      width: 1,
                      color: Colors.grey.withOpacity(.5),
                    ),
                  ],
                ),
                itemCount: events.length,
              ),
            );
          } else {
            return FullScreenError(exception: EESUpException(message: ''));
          }
        },
      ),
    );
  }
}
