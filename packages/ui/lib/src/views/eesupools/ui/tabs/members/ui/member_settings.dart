import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/bloc/member_settings_bloc.dart';

class MemberSettingsDialog extends StatelessWidget {
  const MemberSettingsDialog({
    super.key,
    required this.pool,
    required this.selectedMember,
  });
  final EESUpool pool;
  final EESUpoolMember selectedMember;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemberSettingsBloc(context.read<EESUpoolRepository>())
            ..add(MemberSettingsInitialized(selectedMember)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: Text(selectedMember.fullName),
        ),
        body: BlocBuilder<MemberSettingsBloc, MemberSettingsState>(
          builder: (context, state) {
            if (state is MemberSettingsLoaded) {
              final member = state.member;
              final isMe = pool.memberId == selectedMember.memberId;

              return AbsorbPointer(
                absorbing: isMe,
                child: ListView(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  children: [
                    if (isMe)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(IconlyLight.lock, size: 13),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'You cannot modify your own settings',
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Joined on',
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormatter.yetAnotherDateFormat(
                            member.createdAt,
                          ),
                          style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                    15.sH,
                    Text(
                      'Role',
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
                        value: member.role,
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

                          context.read<MemberSettingsBloc>().add(
                                MemberSettingsUpdated(
                                  member.copyWith(role: newValue),
                                ),
                              );
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.only(top: 15),
                      title: Text(
                        'Restrict Member',
                        style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'All actions they perform will require approval from the admin',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 50,
                        child: Switch(
                          value: member.isCensored,
                          onChanged: (bool value) {
                            context.read<MemberSettingsBloc>().add(
                                  MemberSettingsUpdated(
                                    member.copyWith(isCensored: value),
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    if (pool.type == EESUpoolType.kasi)
                      ListTile(
                        onTap: () {
                          // context.push(TransferMembersScreen.route,
                          //     extra: member);
                        },
                        contentPadding: const EdgeInsets.only(top: 15),
                        title: Text(
                          'Transfer member',
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Transfer this member to another pool',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(IconlyLight.arrowRight2, size: 20),
                      ),
                    if (pool.type != EESUpoolType.kasi)
                      ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.only(top: 15),
                        title: Text(
                          'Remove Member',
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Remove this member from the pool',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(IconlyLight.arrowRight2, size: 20),
                      ),
                  ],
                ),
              );
            } else if (state is MemberSettingsLoading) {
              return const FullScreenLoadingShimmer();
            } else {
              return FullScreenError(
                exception: EESUpException(message: ''),
              );
            }
          },
        ),
      ),
    );
  }
}
