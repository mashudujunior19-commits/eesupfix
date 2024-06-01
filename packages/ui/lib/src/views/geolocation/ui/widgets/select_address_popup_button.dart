import 'package:auto_route/auto_route.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/geolocation/ui/widgets/select_addresses_dialog.dart';
import 'package:flutter/material.dart';

class AddressSelctionPopUpButton extends StatelessWidget {
  const AddressSelctionPopUpButton({
    super.key,
    this.label,
    this.isPersonal = false,
    required this.onAddressSelected,
  });
  final bool isPersonal;
  final Widget? label;
  final void Function(Address?) onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: label ?? Text('Add Address', style: context.textTheme.labelSmall),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () async {
              final results = await context.showBottomSheetDialog(
                  child: const SelectFromMyAddressesDialogBody());

              if (results != null) {
                if (results is Address) {
                  context.loaderOverlay.show();
                  final copy = await context.read<GeoRepository>().saveAddress(
                        results.copyWith(
                          isPrimary: false,
                          id: null,
                          userId: null,
                        ),
                        false,
                      );
                  context.loaderOverlay.hide();

                  copy.fold((left) {
                    context.snackBarError(left.message);
                  }, (right) {
                    onAddressSelected(right);
                  });
                }
              }
            },
            child: Text(
              'Select from my addresses',
              style: context.textTheme.labelSmall,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              context.router
                  .push(EditAddressRoute(isPersonal: isPersonal))
                  .then((value) {
                if (value != null) {
                  onAddressSelected(value as Address?);
                }
              });
            },
            child: Text(
              'Add new address',
              style: context.textTheme.labelSmall,
            ),
          ),
        ];
      },
    );
  }
}
