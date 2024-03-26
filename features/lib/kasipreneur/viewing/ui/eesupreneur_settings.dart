import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';

import 'package:features/geolocation/ui/widgets/edit_address_dialog.dart';
import 'package:flutter/material.dart';

class KasipreneurSettings extends StatelessWidget {
  const KasipreneurSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: ElevatedButton(
          onPressed: () async {
            // final ep = subjectRead(ref);

            // if (ep != null) {
            //   context.loaderOverlay.show();

            //   final repo = ref.read(eesupreneurRepoProvider);
            //   final results = await repo.saveChanges(ep);
            //   context.loaderOverlay.hide();

            //   results.fold((l) {
            //     context.snackBarError(l.message);
            //   }, (r) {
            //     if (r) {
            //       context.snackBarSuccess('Changes saved');
            //     } else {
            //       context.snackBarError('Failed to save changes');
            //     }
            //   });
            // }
          },
          child: const Text('Save Changes'),
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 400),
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
                          value: false,
                          onChanged: (v) {
                            // final ep = subjectRead(ref);
                            // if (ep != null) {
                            //   setEESUpreneur(
                            //     ref,
                            //     ep.copyWith(
                            //       isHidden: v,
                            //     ),
                            //   );
                            // }
                          }),
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
                      InkWell(
                        onTap: () {
                          editAddressDialog(context, isPersonal: false)
                              .then((value) {
                            // if (value != null) {
                            //   final ep = subjectRead(ref);
                            //   if (ep != null) {
                            //     setEESUpreneur(
                            //       ref,
                            //       ep.copyWith(
                            //         address: value as Address?,
                            //       ),
                            //     );
                            //   }
                            // }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  // subtitle: subject(ref)?.address != null
                  //     ? AddressCard(
                  //         address: subject(ref)!.address!,
                  //         margin: const EdgeInsets.only(top: 10),
                  //         allowDelete: false,
                  //       )
                  //     : Text(
                  //         'Your address is required, for your shop to be visible.',
                  //         style: context.textTheme.labelSmall
                  //             ?.copyWith(fontSize: 10),
                  //       ),
                ),
                EESUpTextFormField(
                  label: 'Name',
                  //initialValue: subjectRead(ref)?.name,
                  onChanged: (v) {
                    // final ep = subjectRead(ref);
                    // if (ep != null) {
                    //   setEESUpreneur(
                    //     ref,
                    //     ep.copyWith(
                    //       name: v,
                    //     ),
                    //   );
                    // }
                  },
                ),
                EESUpTextFormField(
                  maxLines: 5,
                  label: 'About',
                 /// initialValue: subjectRead(ref)?.description,
                  onChanged: (v) {
                    // final ep = subjectRead(ref);
                    // if (ep != null) {
                    //   setEESUpreneur(
                    //     ref,
                    //     ep.copyWith(
                    //       description: v,
                    //     ),
                    //   );
                    // }
                  },
                ),
                EESUpTextFormField(
                  label: 'Delivery Fee(R)',
                  // initialValue:
                  //     subjectRead(ref)?.deliveryFee?.toStringAsFixed(2),
                  onChanged: (v) {
                    // final ep = subjectRead(ref);
                    // if (ep != null) {
                    //   setEESUpreneur(
                    //     ref,
                    //     ep.copyWith(
                    //       deliveryFee: double.tryParse(v),
                    //     ),
                    //   );
                    // }
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

          25.sH,
          // Text('Schedule'),
          // Container(
          //   child: Column(children: []),
          // )
        ],
      ),
    );
  }
}
