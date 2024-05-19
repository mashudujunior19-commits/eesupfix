import 'package:auto_route/auto_route.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/geolocation/bloc/addresses_bloc.dart';
import 'package:ui/src/features/geolocation/ui/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AddressesBloc(context.read<GeoRepository>())
          ..add(AddressesFetched()),
        child: BlocConsumer<AddressesBloc, AddressesState>(
          listener: (context, state) {
            if (state is AddressesError) {
              context.snackBarError(state.ex.message);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const Text('Addresses'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.router
                          .push(
                              EditAddressRoute(address: null, isPersonal: true))
                          .then((value) {
                        if (value != null) {
                          context.read<AddressesBloc>().add(AddressesFetched());
                        }
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                  10.sW,
                ],
              ),
              body: Container(
                width: context.width,
                height: context.height,
                decoration: context.bgImage,
                child: () {
                  if (state is AddressesLoaded) {
                    if (state.addresses.isEmpty) {
                      return FullScreenError(
                        isError: false,
                        exception: EESUpException(
                          message: 'You don\'t addresses saved yet.',
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.addresses.length,
                      itemBuilder: (context, index) {
                        final address = state.addresses[index];
                        return AddressCard(address: address)
                            .animate()
                            .slideIn(index * 50);
                      },
                    );
                  } else if (state is AddressesLoading) {
                    return const FullScreenLoadingShimmer();
                  }
                }(),
              ),
            );
          },
        ),
      ),
    );
  }
}
