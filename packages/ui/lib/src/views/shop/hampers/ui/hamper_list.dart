import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import '../bloc/hamper_bloc.dart';

@RoutePage()
class HampersList extends StatelessWidget {
  const HampersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HamperBloc(context.read<ShoppingRepository>())..add(FetchHampers()),
      child: SizedBox(
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Hampers'),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BlocBuilder<HamperBloc, HamperState>(
              builder: (context, state) {
                if (state is HamperLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is HamperError) {
                  return FullScreenError(
                      exception: EESUpException(message: state.message));
                } else if (state is HampersLoaded) {
                  final hampers = state.hampers;

                  if (hampers.isEmpty) {
                    return FullScreenError(
                      exception:
                          EESUpException(message: 'No hampers available'),
                      isError: false,
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 300),
                    itemCount: hampers.length,
                    itemBuilder: (context, index) {
                      final hamper = hampers[index];
                      return _HamperCard(hamper: hamper);
                    },
                  );
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                        message: 'Something went wrong while fetching hampers'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HamperCard extends StatelessWidget {
  const _HamperCard({required this.hamper});
  final Hamper hamper;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(HamperViewRoute(hamperId: hamper.id));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 21, left: 19, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 5),
          title: Text(hamper.hamperCode),
          subtitle: Text(
            "Type: ${hamper.type} | Expires on: ${hamper.expiryDate.toLocal().toString().split(' ')[0]}",
            style: TextStyle(color: Colors.grey[700]),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        ),
      ),
    );
  }
}
