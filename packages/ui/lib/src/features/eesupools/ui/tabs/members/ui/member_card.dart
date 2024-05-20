import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/features/eesupools/ui/tabs/members/ui/member_settings.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.member,
    required this.pool,
    this.trailing,
    this.margin,
    this.onTap,
  });
  final EdgeInsets? margin;
  final EESUpoolMember member;
  final EESUpool pool;
  final Widget? trailing;
  final void Function()? onTap;

  bool isMe(String id) {
    return pool.memberId == id;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap ??
          () {
            // if (pool.memberId == member.memberId) {
            //   context.snackBarError('You can not modify your own settings.');
            //   return;
            // }
            // if (pool.role != EESUpoolMemberRole.admin) return;

            context.showBottomSheetDialog(
              child: MemberSettingsDialog(
                pool: pool,
                selectedMember: member,
              ),
            );
          },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 15, left: 15, top: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 5, right: 10),
          leading: CircleAvatar(
            backgroundColor: context.colorScheme.primary.withOpacity(.06),
            child: Text(member.fullName[0]),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(member.fullName),
              const SizedBox(width: 10),
              if (member.isCensored && pool.role == EESUpoolMemberRole.admin)
                const Tooltip(
                  message: 'Restricted',
                  child: Icon(
                    BootstrapIcons.shield_lock,
                    color: Colors.red,
                    size: 13,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                member.role.toString(),
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colorScheme.primary,
                  fontSize: 11,
                ),
              ),
              2.sH,
              if (pool.role != EESUpoolMemberRole.admin && isMe(member.userId))
                InkWell(
                  onTap: () {
                    context.showAlertDialog(
                      'Leave EESUpool',
                      'Are you sure you want to leave this ${pool.type.toString()}?',
                      positiveText: 'Yes, Leave',
                      negativeText: 'No, Stay',
                      negativeColor: context.colorScheme.primary,
                      positiveColor: context.colorScheme.error,
                      onPositive: () async {
                        // context.loaderOverlay.show();
                        // final results = await ref
                        //     .read(eesupoolRepoProvider)
                        //     .leaveEESUpool(member.eesupoolId);
                        // context.loaderOverlay.hide();

                        // results.fold((l) {
                        //   context.snackBarError(l.message);
                        // }, (r) {
                        //   context.snackBarSuccess(
                        //     'You have left ${pool.name.toString()} ${pool.type.toString()}',
                        //   );
                        //   context.pop();
                        // });
                      },
                      onNegative: () {},
                    );
                  },
                  child: Text(
                    'Leave this ${pool.type.toString()}',
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.error,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
          trailing: trailing ?? const Icon(IconlyLight.arrowRight2, size: 15),
        ),
      ),
    );
  }
}
