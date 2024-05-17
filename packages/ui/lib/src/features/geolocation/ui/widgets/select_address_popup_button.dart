import 'package:auto_route/auto_route.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/features/geolocation/ui/widgets/select_addresses_dialog.dart';
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
            onTap: () {
              context
                  .showBottomSheetDialog(
                      child: const SelectFromMyAddressesDialogBody())
                  .then((value) {
                if (value != null) {
                  onAddressSelected(value as Address?);
                }
              });
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
