import 'package:auto_route/auto_route.dart';
import 'package:data_sources/geolocation/models/address.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:features/geolocation/ui/widgets/edit_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Address> addresses = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Addresses'),
          actions: [
            IconButton(
              onPressed: () {
                editAddressDialog(context).then(
                  (value) {
                    if (value != null) {
                      //  ref.invalidate(addressesProvider);
                    }
                  },
                );
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
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return AddressCard(address: address)
                  .animate()
                  .fadeIn(delay: (200 + index * 50).ms)
                  .slide(
                    delay: (100 * index).ms,
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0),
                    duration: 600.ms,
                    curve: Curves.easeInOutCubic,
                  );
            },
          ),
        ),
      ),
    );
  }
}
