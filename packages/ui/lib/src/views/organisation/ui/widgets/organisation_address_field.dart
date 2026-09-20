import 'package:data/geolocation/models/address.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/geolocation/ui/widgets/address_card.dart';
import 'package:ui/src/views/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:flutter/material.dart';

class OrganisationAddressField extends StatelessWidget {
  const OrganisationAddressField({
    super.key,
    required this.address,
    required this.onAddressSelected,
  });

  final Address? address;
  final void Function(Address?) onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Address',
              style: context.textTheme.labelMedium?.copyWith(fontSize: 14),
            ),
            AddressSelctionPopUpButton(
              label: Icon(
                Icons.add,
                color: context.colorScheme.primary,
              ),
              onAddressSelected: onAddressSelected,
            ),
          ],
        ),
        if (address != null)
          AddressCard(
            address: address!,
            margin: const EdgeInsets.only(top: 5),
            allowDelete: false,
          )
        else
          Text(
            'No address selected yet.',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 12.5,
            ),
          ),
        10.sH,
      ],
    );
  }
}
