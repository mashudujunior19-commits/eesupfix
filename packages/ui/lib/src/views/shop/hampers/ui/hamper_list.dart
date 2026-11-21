import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';

import '../bloc/hamper_bloc.dart';
import 'hamper_widgets.dart';

@RoutePage()
class HampersList extends StatelessWidget {
  const HampersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HamperBloc(context.read<ShoppingRepository>())..add(LoadHampers()),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Hampers'),
        ),
        body: BlocBuilder<HamperBloc, HamperState>(
          builder: (context, state) {
            if (state is HamperLoading || state is HamperInitial) {
              return const FullScreenLoadingShimmer();
            }
            if (state is HamperError) {
              return HamperRetry(
                message: state.message,
                onRetry: () => context.read<HamperBloc>().add(LoadHampers()),
              );
            }
            if (state is HampersLoaded) {
              if (state.hampers.isEmpty) {
                return FullScreenError(
                  exception: EESUpException(message: 'No hampers available'),
                  isError: false,
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HamperBloc>().add(LoadHampers());
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 120, top: 4),
                  itemCount: state.hampers.length,
                  itemBuilder: (context, index) =>
                      _HamperCard(hamper: state.hampers[index]),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _HamperCard extends StatelessWidget {
  const _HamperCard({required this.hamper});
  final HamperOffer hamper;

  @override
  Widget build(BuildContext context) {
    final endsIn = hamperEndsIn(hamper);
    return Semantics(
      button: true,
      label: 'Hamper ${hamper.code}, ${hamperMoney(hamper.price)}',
      child: InkWell(
        onTap: () => context.router.push(HamperViewRoute(hamperId: hamper.id)),
        child: Container(
          margin: const EdgeInsets.only(right: 21, left: 19, top: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: .5),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 84,
                  height: 84,
                  child: HamperPicture(imgUrl: hamper.imgUrl, height: 84),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hamper.code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hamperMoney(hamper.price),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (hamper.saving > 0)
                          HamperChip('Save ${hamperMoney(hamper.saving)}',
                              highlight: true),
                        if (hamper.itemCount > 0)
                          HamperChip('${hamper.itemCount} items'),
                        if (endsIn != null) HamperChip(endsIn),
                        if (!hamper.canBuy) const HamperChip('Unavailable'),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
