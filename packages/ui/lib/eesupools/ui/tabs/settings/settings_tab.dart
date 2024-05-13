import 'package:data/eesupools/models/eesupool.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:ui/eesupools/bloc/eesupool_view_bloc.dart';
import 'package:ui/geolocation/ui/widgets/address_card.dart';
import 'package:ui/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key, required this.pool});
  final EESUpool pool;

  bool feesBalanced() {
    double perc = (pool.adminFee ?? 0) +
        (pool.receivingFee ?? 0) +
        (pool.packagingFee ?? 0) +
        (pool.collectionFee ?? 0);
    final value = perc == 100.00;

    return value;
  }

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
            initialValue: pool.name,
            onChanged: (value) {
              context.read<EESUpoolViewBloc>().add(
                    EESUpoolSettingsUpdated(
                      pool.copyWith(name: value),
                      value.isNotEmpty && feesBalanced(),
                    ),
                  );
            },
          ),
          EESUpTextFormField(
            label: 'About',
            maxLines: 5,
            initialValue: pool.description,
            onChanged: (value) {
              context.read<EESUpoolViewBloc>().add(
                    EESUpoolSettingsUpdated(
                      pool.copyWith(description: value),
                      feesBalanced(),
                    ),
                  );
            },
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
              value: pool.isPublic,
              activeTrackColor: context.colorScheme.primary,
              onChanged: (bool value) {
                context.read<EESUpoolViewBloc>().add(
                      EESUpoolSettingsUpdated(
                        pool.copyWith(isPublic: value),
                        feesBalanced(),
                      ),
                    );
              },
            ),
          ),
          if (pool.isPublic)
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
                    onAddressSelected: (address) {
                      context.read<EESUpoolViewBloc>().add(
                            EESUpoolSettingsUpdated(
                              pool.copyWith(address: address),
                              feesBalanced(),
                            ),
                          );
                    },
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
              if (!feesBalanced())
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconlyLight.infoSquare,
                      size: 17,
                      color: context.colorScheme.error,
                    ),
                    10.sW,
                    Text(
                      'Ensure that the allocations sum up to 100%',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                  ],
                ).animate().shakeX(),
              EESUpTextFormField(
                label: 'Administration fee(%)',
                initialValue: pool.adminFee?.toStringAsFixed(2),
                type: TextInputType.number,
                onChanged: (value) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(adminFee: double.tryParse(value)),
                          feesBalanced(),
                        ),
                      );
                },
              ),
              EESUpTextFormField(
                label: 'Collection fee(%)',
                maxLines: 1,
                initialValue: pool.collectionFee?.toStringAsFixed(2),
                onChanged: (value) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(collectionFee: double.tryParse(value)),
                          feesBalanced(),
                        ),
                      );
                },
              ),
              EESUpTextFormField(
                label: 'Recieving fee(%)',
                maxLines: 1,
                initialValue: pool.receivingFee?.toStringAsFixed(2),
                onChanged: (value) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(receivingFee: double.tryParse(value)),
                          feesBalanced(),
                        ),
                      );
                },
              ),
              EESUpTextFormField(
                label: 'Packaging fee(%)',
                maxLines: 1,
                initialValue: pool.packagingFee?.toStringAsFixed(2),
                onChanged: (value) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(packagingFee: double.tryParse(value)),
                          feesBalanced(),
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
