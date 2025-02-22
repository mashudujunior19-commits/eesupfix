import 'package:data/eesupools/models/eesupool.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/eesupools/bloc/eesupool_view_bloc.dart';
import 'package:ui/src/views/geolocation/ui/widgets/address_card.dart';
import 'package:ui/src/views/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            initialValue: pool.name,
            onChanged: (value) {
              if (value.isEmpty) return;

              context
                  .read<EESUpoolViewBloc>()
                  .add(EESUpoolSettingsUpdated(pool.copyWith(name: value)));
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
                if (value == true) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(isPublic: value),
                        ),
                      );
                } else {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolSettingsUpdated(
                          pool.copyWith(
                              isPublic: value, address: null, addressId: null),
                        ),
                      );
                }
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
                      if (address != null) {
                        context.read<EESUpoolViewBloc>().add(
                              EESUpoolSettingsUpdated(pool.copyWith(
                                  address: address, addressId: address.id)),
                            );
                      }
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
                      allowDelete: false,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconlyLight.infoSquare,
                    size: 17,
                    color: Colors.grey.shade800,
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Ensure that the allocations sum up to 100%, Otherwise the changes will not be saved',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade800,
                      ),
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
                        EESUpoolPercentagesUpdated(
                          pool.copyWith(
                            adminFee: double.tryParse(value),
                          ),
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
                        EESUpoolPercentagesUpdated(
                          pool.copyWith(
                            packagingFee: double.tryParse(value),
                          ),
                        ),
                      );
                },
              ),
              EESUpTextFormField(
                label: 'Dispatching fee(%)',
                maxLines: 1,
                initialValue: pool.collectionFee?.toStringAsFixed(2),
                onChanged: (value) {
                  context.read<EESUpoolViewBloc>().add(
                        EESUpoolPercentagesUpdated(
                          pool.copyWith(
                            collectionFee: double.tryParse(value),
                          ),
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
                        EESUpoolPercentagesUpdated(
                          pool.copyWith(
                            receivingFee: double.tryParse(value),
                          ),
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
