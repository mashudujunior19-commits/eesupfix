import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/eesupools/ui/widgets/eesupool_card.dart';

@RoutePage()
class TransferMemberScreen extends StatefulWidget {
  const TransferMemberScreen({super.key, required this.member});
  final EESUpoolMember member;

  @override
  State<TransferMemberScreen> createState() => _TransferMemberScreenState();
}

class _TransferMemberScreenState extends State<TransferMemberScreen> {
  final controller = TextEditingController();
  EESUpoolMemberRole role = EESUpoolMemberRole.member;
  @override
  void initState() {
    super.initState();
    role = widget.member.role;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const Text('Transfer Member'),
        ),
        body: Column(
          children: [
            15.sH,
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Role in the new Kasi',
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: DropdownButton<EESUpoolMemberRole>(
                      // Initial Value
                      value: role,
                      dropdownColor: Colors.white,
                      isExpanded: true,

                      underline: const SizedBox.shrink(),
                      // Down Arrow Icon
                      icon: const Icon(IconlyLight.arrowDown2, size: 20),
                      borderRadius: BorderRadius.circular(15),
                      elevation: 3,
                      // Array list of items
                      items: EESUpoolMemberRole.values
                          .map((EESUpoolMemberRole value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.toString(),
                              style: context.textTheme.labelMedium),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (EESUpoolMemberRole? newValue) {
                        if (newValue == null) return;

                        setState(() {
                          role = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: EESUpTextFormField(
                controller: controller,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(IconlyLight.search),
                ),
                hintText: 'Search a new kasi for'
                    ' ${widget.member.fullName.split(' ').first}',
                onChanged: (v) {
                  setState(() {});
                },
              ),
            ),
            if (controller.text.isNotEmpty)
              FutureBuilder<List<EESUpool>>(
                future: context
                    .read<EESUpoolRepository>()
                    .searchEESUpoolsDescendents2(
                      query: controller.text,
                      poolId: widget.member.eesupoolId,
                      limit: 50,
                    ),
                builder: (context, snap) {
                  if (snap.data != null) {
                    final pools = snap.data ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: pools.length,
                        itemBuilder: (context, index) {
                          return EESUpoolCard(
                            eesupool: pools[index],
                            onPoolTap: (p) async {
                              context.loaderOverlay.show();
                              final res = await context
                                  .read<EESUpoolRepository>()
                                  .transferMember(
                                    widget.member.memberId,
                                    p.eesupoolId!,
                                    role,
                                  );
                              context.loaderOverlay.hide();

                              res.fold((l) {
                                context.snackBarError(
                                  'Something went wrong while transfering member',
                                );
                              }, (r) {
                                if (r) {
                                  context.snackBarSuccess('Member transfered');
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                } else {
                                  context.snackBarError(
                                    'Something went wrong while transfering member',
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
