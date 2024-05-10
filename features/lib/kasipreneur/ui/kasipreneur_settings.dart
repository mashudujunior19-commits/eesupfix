import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/eesupreneur/models/eesupreneur.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:features/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:features/kasipreneur/bloc/kasipreneur_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KasipreneurSettingsTab extends StatelessWidget {
  const KasipreneurSettingsTab({super.key, required this.eesupreneur});
  final EESUpreneur eesupreneur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(.2),
                    child: const Icon(BootstrapIcons.eye, size: 20),
                  ),
                  title: Text(
                    'Hide My Shop',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(
                    'When the the shop is hidden, people will not be able to place orders for collection from you.',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  trailing: SizedBox(
                    height: 20,
                    child: Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: eesupreneur.isHidden ?? false,
                        onChanged: (v) {
                          context.read<KasipreneurViewBloc>().add(
                                KasipreneurViewUpdated(
                                  eesupreneur.copyWith(isHidden: v),
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: context.textTheme.labelMedium?.copyWith(),
                      ),
                      AddressSelctionPopUpButton(
                        isPersonal: false,
                        label: Icon(
                          Icons.add,
                          color: context.colorScheme.primary,
                        ),
                        onAddressSelected: (value) {
                          if (value != null) {
                            context.read<KasipreneurViewBloc>().add(
                                  KasipreneurViewUpdated(
                                    eesupreneur.copyWith(address: value),
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                  subtitle: eesupreneur.address != null
                      ? AddressCard(
                          address: eesupreneur.address!,
                          margin: const EdgeInsets.only(top: 10),
                          allowDelete: false,
                        )
                      : Text(
                          'Your address is required, for your shop to be visible.',
                          style: context.textTheme.labelSmall
                              ?.copyWith(fontSize: 10),
                        ),
                ),
                EESUpTextFormField(
                  label: 'Name',
                  initialValue: eesupreneur.name,
                  onChanged: (v) {
                    context.read<KasipreneurViewBloc>().add(
                          KasipreneurViewUpdated(
                            eesupreneur.copyWith(name: v),
                          ),
                        );
                  },
                ),
                EESUpTextFormField(
                  maxLines: 5,
                  label: 'About',
                  initialValue: eesupreneur.description,
                  onChanged: (v) {
                    context.read<KasipreneurViewBloc>().add(
                          KasipreneurViewUpdated(
                            eesupreneur.copyWith(description: v),
                          ),
                        );
                  },
                ),
                EESUpTextFormField(
                  label: 'Delivery Fee(R)',
                  initialValue: eesupreneur.deliveryFee?.toStringAsFixed(2),
                  type: TextInputType.number,
                  onChanged: (v) {
                    final amount = double.tryParse(v);
                    context.read<KasipreneurViewBloc>().add(
                          KasipreneurViewUpdated(
                            eesupreneur.copyWith(deliveryFee: amount),
                          ),
                        );
                  },
                ),
                Text(
                  'If you wish to offer delivery, please enter the fee below. otherwise leave it blank.',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          400.sH,
          // Text('Schedule'),
          // Container(
          //   child: Column(children: []),
          // )
        ],
      ),
    );
  }
}
