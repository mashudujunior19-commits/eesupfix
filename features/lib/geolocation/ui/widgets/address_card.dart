import 'package:data_sources/geolocation/models/address.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    this.allowDelete = true,
    this.onTap,
    this.margin,
    this.color,
  });
  final Color? color;
  final EdgeInsets? margin;
  final Address address;
  final bool allowDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap ??
          () {
            // editAddressDialog(context, address: address, isPersonal: true)
            //     .then(
            //   (value) {
            //     if (value != null) {
            //       ref.invalidate(addressesProvider);
            //     }
            //   },
            // );
          },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 17, left: 17, top: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primary.withOpacity(
              .2,
            ),
            child: Icon(
              IconlyLight.location,
              color: theme.colorScheme.primary,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.streetAddress,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  if (address.buildingName != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '${address.buildingName}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Text(
                    address.province,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              5.sH,
              Row(
                children: [
                  Text(
                    '👨🏽‍🦱 ${address.recipientName}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.sW,
                  Text(
                    '📞 ${address.recipientPhone}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              10.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (address.areaId != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              color: theme.colorScheme.primary,
                              size: 17,
                            ),
                            Text(
                              ' Verified  ',
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const Tooltip(
                              margin: EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              message:
                                  'Verified means this address is within one of EESUp\'s operational area',
                              child: Icon(
                                Icons.help_outline,
                                size: 14,
                              ),
                            ),
                            10.sW,
                          ],
                        ),
                      if (address.isPrimary)
                        Text(
                          'Primary',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.primary.withOpacity(.5),
                          ),
                        ),
                    ],
                  ),
                  if (allowDelete)
                    InkWell(
                      onTap: () {
                        // ref
                        //     .read(geoRepoProvider)
                        //     .deleteAddress(address.id!)
                        //     .whenComplete(() {
                        //   ref.invalidate(addressesProvider);
                        // });
                      },
                      child: const Icon(
                        IconlyBold.delete,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
