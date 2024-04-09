import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:features/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.3),
      child: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 200),
        children: [
          15.sH,
          Text('Primary Details', style: context.textTheme.labelLarge),
          const Divider(thickness: .5),
          EESUpTextFormField(
            label: 'Name',
            initialValue: null,
            onChanged: (value) {},
          ),
          EESUpTextFormField(
            label: 'About',
            maxLines: 5,
            initialValue: null,
            onChanged: (value) {},
          ),
          10.sH,
          Text('Privacy', style: context.textTheme.labelLarge),
          const Divider(thickness: .5),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 15),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(IconlyLight.lock, color: Colors.black, size: 18),
                const SizedBox(width: 10),
                Text(
                  'Public',
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            subtitle: Text(
              'When this is set to true, new members can request'
              ' to join the EESUpool. If disabled, only admins'
              ' have the ability to invite new members.',
              style: context.textTheme.bodySmall,
            ),
            trailing: Switch(
              value: true,
              activeTrackColor: context.colorScheme.primary,
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(IconlyLight.location,
                        color: Colors.black, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      'Location',
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
                AddressSelctionPopUpButton(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconlyLight.plus,
                        size: 17,
                        color: context.colorScheme.primary,
                      ),
                      5.sW,
                      Text(
                        'Add/Edit',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  onAddressSelected: (address) {},
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.sH,
                Text(
                  'We use this location to make it easy for potential members to find the EESUpool.',
                  style: context.textTheme.bodySmall,
                ),
                if (pool.address != null)
                  AddressCard(
                    address: pool.address!,
                    margin: const EdgeInsets.only(top: 10),
                  )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              15.sH,
              Text(
                'Orders Earnings Allocations',
                style: context.textTheme.labelLarge,
              ),
              const Divider(thickness: .5),
              EESUpTextFormField(
                label: 'Administration fee(%)',
                initialValue: null,
                onChanged: (value) {},
              ),
              EESUpTextFormField(
                label: 'Collection fee(%)',
                maxLines: 1,
                initialValue: null,
                onChanged: (value) {},
              ),
              EESUpTextFormField(
                label: 'Recieving fee(%)',
                maxLines: 1,
                initialValue: null,
                onChanged: (value) {},
              ),
              EESUpTextFormField(
                label: 'Packaging fee(%)',
                maxLines: 1,
                initialValue: null,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
