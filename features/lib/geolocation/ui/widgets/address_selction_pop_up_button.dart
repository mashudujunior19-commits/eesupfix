import 'package:data_sources/geolocation/models/address.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/geolocation/ui/widgets/edit_address_dialog.dart';
import 'package:flutter/material.dart';

class AddressSelctionPopUpButton extends StatelessWidget {
  const AddressSelctionPopUpButton({
    super.key,
    this.label,
    required this.onAddressSelected,
  });
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
              // selectFromMyAddressDialog(context).then((value) {
              //   if (value != null) {
              //     onAddressSelected(value as Address?);
              //   }
              // });
            },
            child: Text(
              'Select from my addresses',
              style: context.textTheme.labelSmall,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              editAddressDialog(context, isPersonal: false).then((value) {
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
