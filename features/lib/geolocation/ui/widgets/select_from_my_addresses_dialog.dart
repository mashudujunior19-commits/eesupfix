import 'package:data_sources/geolocation/models/address.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<Object?> selectFromMyAddressDialog(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _SelectFromMyAddresses();
    },
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeIn,
    duration: 400.ms,
  );
}

class _SelectFromMyAddresses extends StatelessWidget {
  const _SelectFromMyAddresses();

  @override
  Widget build(BuildContext context) {
    final List<Address> addresses = [];
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .07),
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Select Address'),
          actions: [
            IconButton(
              onPressed: () {
                // editAddressDialog(context, isPersonal: true).then(
                //   (value) {
                //     // if (value != null) {
                //     //   ref.invalidate(addressesProvider);
                //     // }
                //   },
                // );
              },
              icon: const Icon(Icons.add),
            ),
            3.sW,
          ],
        ),
        body: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            return AddressCard(
              address: address,
              allowDelete: false,
              onTap: () async {
                // context.loaderOverlay.show();

                // final saveResults =
                //     await ref.read(geoRepoProvider).saveAddress(address, false);

                // if (context.mounted) {
                //   context.loaderOverlay.hide();
                // }

                // saveResults.fold((l) {
                //   context.snackBarError(l.message);
                // }, (r) {
                //   context.snackBarSuccess('Address saved successfully');
                //   Navigator.of(context).pop(
                //     /// Copy the address to remove the userId
                //     /// So that it can be used as a new address
                //     address.copyWith(userId: null),
                //   );
                // });
              },
            ).animate().slideIn(index * 50);
          },
        ),
      ),
    ));
  }
}
