import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:features/core/widgets/large_loading_shimmer.dart';
import 'package:features/geolocation/bloc/addresses_bloc.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/geolocation/geo_repository.dart';

class SelectFromMyAddressesDialogBody extends StatelessWidget {
  const SelectFromMyAddressesDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressesBloc(context.read<GeoRepository>()),
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
              title: const Text('Select Address'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.router
                        .push(EditAddressRoute(
                            address: null, isPersonal: true))
                        .then((value) {
                      if (value != null) {
                        context
                            .read<AddressesBloc>()
                            .add(AddressesFetched());
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                3.sW,
              ],
            ),
            body: () {
              if (state is AddressesLoaded) {
                return ListView.builder(
                  itemCount: state.addresses.length,
                  itemBuilder: (context, index) {
                    final address = state.addresses[index];
                    return AddressCard(
                      address: address,
                      onTap: () {
                        Navigator.of(context).pop(address);
                      },
                    ).animate().slideIn(index * 50);
                  },
                );
              } else if (state is AddressesLoading) {
                return const LargeLoadingShimmer();
              }
            }(),
          );
        },
      ),
    );
  }
}
