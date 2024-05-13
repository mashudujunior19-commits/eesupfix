// ignore_for_file: use_build_context_synchronously

import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/core/extensions/context_alerts_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:ui/eesupools/ui/tabs/members/ui/member_card.dart';
import 'package:ui/eesupools/ui/tabs/members/ui/select_member_dialog.dart';
import 'package:ui/geolocation/ui/widgets/address_card.dart';
import 'package:ui/geolocation/ui/widgets/select_address_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CreatePoolOrderDialog extends StatefulWidget {
  const CreatePoolOrderDialog({
    super.key,
    this.order,
    required this.pool,
  });
  final EESUpool pool;
  final EESUpoolOrder? order;

  @override
  State<CreatePoolOrderDialog> createState() => _CreatePoolOrderDialogState();
}

class _CreatePoolOrderDialogState extends State<CreatePoolOrderDialog> {
  EESUpoolOrder? order = EESUpoolOrder(
    id: 0,
    eesupoolId: 0,
    createdAt: DateTime.now(),
    scheduleFor: DateTime.now().add(const Duration(days: 3)),
    closesAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();

    if (widget.order != null) {
      order = widget.order;
    }

    order = order?.copyWith(eesupoolId: widget.pool.eesupoolId!);

    if (widget.pool.address != null) {
      order = order!.copyWith(
        address: widget.pool.address,
        addressId: widget.pool.address!.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(widget.order == null ? 'Create Order' : 'Edit Order'),
        actions: [
          TextButton(
            onPressed: () async {
              context.loaderOverlay.show();
              if (order != null) {
                final results =
                    await context.read<EESUpoolRepository>().createOrder(
                          order!,
                        );
                context.loaderOverlay.hide();
                results.fold((left) {
                  context.snackBarError(left.message);
                }, (right) {
                  if (right) {
                    context.snackBarSuccess('Order created');
                    Navigator.of(context).pop(true);
                  } else {
                    context.snackBarError(
                      'The order could not be created, Please try again.',
                    );
                  }
                });
              }
            },
            child: const Text('Save'),
          ),
          15.sW,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 400),
        children: [
          EESUpTextFormField(
            label: 'Close date',
            readOnly: true,
            isRequired: true,
            controller: TextEditingController(
                text: order?.closesAt != null
                    ? DateFormatter.formatDateToNameday(order!.closesAt)
                    : null),
            onTap: () async {
              DateTime? date = await showOmniDateTimePicker(
                type: OmniDateTimePickerType.date,
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 3)),
                firstDate: DateTime.now().add(const Duration(days: 3)),
              );
              if (date != null) {
                setState(() {
                  order = order!.copyWith(
                    closesAt: date,
                    scheduleFor: date.add(const Duration(days: 3)),
                  );
                });
              }
            },
          ),
          Text(
            'Note that the Delivery date and Close date must be '
            '3 days apart',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                ),
          ),
          10.sH,
          EESUpTextFormField(
            onTap: () async {
              DateTime? date = await showOmniDateTimePicker(
                type: OmniDateTimePickerType.date,
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 6)),
                firstDate: DateTime.now().add(const Duration(days: 6)),
              );
              if (date != null) {
                setState(() {
                  order = order!.copyWith(
                    scheduleFor: date,
                    closesAt: date.subtract(const Duration(days: 3)),
                  );
                });
              }
            },
            label: 'Delivery date',
            controller: TextEditingController(
                text: order?.scheduleFor != null
                    ? DateFormatter.formatDateToNameday(order!.scheduleFor)
                    : null),
            readOnly: true,
            isRequired: true,
          ),
          10.sH,
          AddressSelctionPopUpButton(
            onAddressSelected: (value) {
              if (value != null) {
                setState(() {
                  order = order!.copyWith(
                    address: value,
                    addressId: value.id,
                  );
                });
              }
            },
            label: Row(
              children: [
                Icon(
                  IconlyLight.location,
                  size: 19,
                  color: context.colorScheme.primary,
                ),
                5.sW,
                Text(
                  order?.address != null
                      ? 'Tap to Edit Address'
                      : 'Tap to Add Address',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          10.sH,
          if (order?.address != null)
            AddressCard(
              address: order!.address!,
              margin: const EdgeInsets.all(0),
              allowDelete: false,
            ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context
                      .showBottomSheetDialog(
                          child: SelectMemberDialog(pool: widget.pool))
                      .then((value) {
                    if (value != null) {
                      if (value is EESUpoolMember) {
                        List<EESUpoolMember> current = [
                          ...order?.receivers ?? []
                        ];
                        if (!current.contains(value)) {
                          current.add(value);
                          setState(() {
                            order = order!.copyWith(
                              receivers: current,
                            );
                          });
                        }
                      }
                    }
                  });
                },
                child: Row(
                  children: [
                    const Icon(IconlyLight.profile, size: 19),
                    5.sW,
                    const Text('Add receivers'),
                  ],
                ),
              ),
            ],
          ),
          for (var member in order?.receivers ?? [])
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                MemberCard(
                  member: member,
                  margin: const EdgeInsets.only(bottom: 10),
                  pool: widget.pool,
                  trailing: InkWell(
                    onTap: () {
                      if (order != null) {
                        List<EESUpoolMember> members = [
                          ...order?.receivers ?? []
                        ];
                        setState(() {
                          members.remove(member);
                          order = order?.copyWith(receivers: members);
                        });
                      }
                    },
                    child: const Icon(
                      IconlyLight.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
