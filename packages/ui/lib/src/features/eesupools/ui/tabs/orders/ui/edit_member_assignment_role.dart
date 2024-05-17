import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/orders/models/order.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/features/eesupools/ui/tabs/members/ui/select_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditOrderAssignmentsDialog extends StatefulWidget {
  const EditOrderAssignmentsDialog({
    super.key,
    required this.order,
    required this.pool,
  });
  final Order order;
  final EESUpool pool;

  @override
  State<EditOrderAssignmentsDialog> createState() =>
      _EditOrderAssignmentsDialogState();
}

class _EditOrderAssignmentsDialogState
    extends State<EditOrderAssignmentsDialog> {
  List<MemberOrderAssignment> assignments = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      assignments = [...widget.order.assignments];
    });
  }

  void addAssignment(EESUpoolMember member) {
    bool alreadyExists =
        assignments.any((element) => element.memberId == member.memberId);

    if (!alreadyExists) {
      setState(() {
        assignments.add(
          MemberOrderAssignment(
            memberId: member.memberId,
            fullName: member.fullName,
            orderId: widget.order.id!,
            eesupoolOrderId: widget.order.eesupoolOrderId!,
            privilage: OrderEditPrivilage.all,
            corpName: null,
          ),
        );
      });
    }
  }

  void setRole(OrderEditPrivilage role, MemberOrderAssignment assignment) {
    setState(() {
      assignment = assignment.copyWith(privilage: role);
    });

    assignments = assignments.map((e) {
      if (e.memberId == assignment.memberId) {
        return assignment;
      }
      return e;
    }).toList();
  }

  bool isValidAssignments(BuildContext cx) {
    int packerCounts = assignments
        .where((element) => element.privilage == OrderEditPrivilage.packer)
        .length;

    if (packerCounts > 1) {
      cx.snackBarError('Only one packer is allowed');
      return false;
    }

    int collectorCounts = assignments
        .where((element) => element.privilage == OrderEditPrivilage.collector)
        .length;

    if (collectorCounts > 1) {
      cx.snackBarError('Only one collector is allowed');
      return false;
    }

    final hasAll = assignments
        .where((element) => element.privilage == OrderEditPrivilage.all)
        .isNotEmpty;

    if (hasAll && packerCounts > 0) {
      cx.snackBarError(
          'If all is selected on one of the members, a packer is not allowed');
      return false;
    }

    if (hasAll && collectorCounts > 0) {
      cx.snackBarError(
          'If all is selected on one of the members, a collector is not allowed');
      return false;
    }
    int allCount = assignments
        .where((element) => element.privilage == OrderEditPrivilage.all)
        .length;

    if (allCount > 1) {
      cx.snackBarError('Only one member can have all privilages');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Edit Assignments'),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .showBottomSheetDialog(
                      child: SelectMemberDialog(pool: widget.pool))
                  .then((value) {
                if (value != null) {
                  addAssignment(value as EESUpoolMember);
                }
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (isValidAssignments(context)) {
              Navigator.of(context).pop(assignments);
            }
          },
          child: const Text('Save'),
        ),
      ),
      body: Container(
        decoration: context.bgImage,
        child: ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (BuildContext context, int index) {
            final assignment = assignments[index];
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 19,
                  child: const Icon(
                    BootstrapIcons.person,
                    color: Colors.grey,
                    size: 19,
                  ),
                ),
                title: Text(
                  assignment.fullName ?? 'Unknown',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    const Text('Role: '),
                    5.sW,
                    SizedBox(
                      height: 25,
                      width: 100,
                      child: DropdownButton<OrderEditPrivilage>(
                        value: assignment.privilage,
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
                        icon: const Icon(IconlyLight.arrowDown2, size: 16),
                        onChanged: (OrderEditPrivilage? value) {
                          if (value == null) {
                            return;
                          }
                          switch (value) {
                            case OrderEditPrivilage.none:
                              setRole(value, assignment);
                              break;
                            case OrderEditPrivilage.packer:
                              setRole(value, assignment);
                              break;
                            case OrderEditPrivilage.collector:
                              setRole(value, assignment);
                              break;
                            case OrderEditPrivilage.owner:
                              return;
                            case OrderEditPrivilage.all:
                              setRole(value, assignment);
                              break;
                          }
                        },
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                        ),
                        items: [
                          OrderEditPrivilage.packer,
                          OrderEditPrivilage.collector,
                          OrderEditPrivilage.all
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.toString(),
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      assignments.removeAt(index);
                    });
                  },
                  child: const Icon(IconlyLight.delete, size: 19),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
