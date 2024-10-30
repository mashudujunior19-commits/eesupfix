import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import '../bloc/hamper_bloc.dart';

@RoutePage()
class HamperImageViewPage extends StatelessWidget {
  final String imageUrl;

  const HamperImageViewPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HamperBloc(context.read<ShoppingRepository>())
        ..add(FetchHampersByImageUrl(imageUrl)), // Fetch hampers by image URL
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hamper Details"),
        ),
        body: BlocBuilder<HamperBloc, HamperState>(
          builder: (context, state) {
            if (state is HamperLoading) {
              return const FullScreenLoadingShimmer();
            } else if (state is HamperError) {
              return FullScreenError(
                exception: EESUpException(
                  message: 'Something went wrong: ${state.message}',
                ),
              );
            } else if (state is HamperLoaded) {
              // Assuming you want to show the first hamper found
              final hamper = state.hampers.isNotEmpty
                  ? state.hampers.first
                  : null; // Handle case when no hampers are found
              return hamper != null
                  ? _buildHamperDetails(context, hamper)
                  : const Center(child: Text('No hampers found.'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHamperDetails(BuildContext context, Hamper hamper) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${hamper.hamperName} (${hamper.hamperCode})',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text("Type: ${hamper.type}"),
                Text("Cost: ${hamper.value}"),
                Text(
                    "Expires on: ${hamper.expiryDate.toLocal().toString().split(' ')[0]}"),
                if (hamper.imgUrl != null) Image.network(hamper.imgUrl!),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Products",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
