import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:features/core/widgets/large_loading_shimmer.dart';
import 'package:features/geolocation/bloc/addresses_bloc.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/geolocation/geo_repository.dart';

class AddressSelectionStep extends StatelessWidget {
  const AddressSelectionStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressesBloc(context.read<GeoRepository>())..add(AddressesFetched()),
      child: BlocConsumer<AddressesBloc, AddressesState>(
        listener: (context, state) {
          if (state is AddressesError) {
            context.snackBarError(state.ex.message);
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            children: [
              const Text('Select your address.'),
              const Divider(thickness: .2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Saved'),
                  InkWell(
                    onTap: () {
                      context.router
                          .push(
                              EditAddressRoute(address: null, isPersonal: true))
                          .then((value) {
                        if (value != null) {
                          context.read<AddressesBloc>().add(AddressesFetched());
                          //TODO: Auto select the returned address to avoid another unnessary click
                        }
                      });
                    },
                    child: const Icon(IconlyLight.plus, size: 20),
                  )
                ],
              ),
              if (state is AddressesLoaded)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.addresses.length,
                  itemBuilder: (context, index) {
                    final address = state.addresses[index];
                    return AddressCard(
                      address: address,
                      margin: const EdgeInsets.only(top: 15),
                      onTap: () {
                        tabController.animateTo(tabController.index + 1);
                      },
                    ).animate().slideIn(index * 50);
                  },
                )
              else if (state is AddressesLoading)
                const LargeLoadingShimmer(
                  margin: EdgeInsets.only(top: 15),
                ),
            ],
          );
        },
      ),
    );
  }
}
