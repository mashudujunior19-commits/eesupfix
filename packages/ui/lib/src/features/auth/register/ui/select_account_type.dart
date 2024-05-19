import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/features/auth/register/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAccountType extends StatelessWidget {
  const SelectAccountType({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      builder: (context, state) {
        if (state is SignUpForm) {
          return Center(
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              children: [
                25.sH,
                Text(
                  'Which account type would you like to create?',
                  style: context.textTheme.labelMedium?.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ).animate().slideIn(0),
                35.sH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _AccountTypeButton(
                      isSelected: false,
                      lable: 'Individual',
                      image: 'assets/images/man.png',
                      comment: 'This is a normal company',
                      onTap: () {
                        context.read<RegistrationBloc>().add(
                              AccountTypeUpdated(false),
                            );
                        tabController.animateTo(tabController.index + 1);
                      },
                    ).animate().slideIn(50),
                    150.sW,
                    _AccountTypeButton(
                      isSelected: false,
                      lable: 'Corporate',
                      image: 'assets/images/enterprise.png',
                      comment: 'This is a normal company',
                      onTap: () {
                        context.read<RegistrationBloc>().add(
                              AccountTypeUpdated(true),
                            );
                        tabController.animateTo(tabController.index + 1);
                      },
                    ).animate().slideIn(100),
                  ],
                ),
                35.sH,
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _AccountTypeButton extends StatelessWidget {
  const _AccountTypeButton({
    required this.isSelected,
    required this.lable,
    required this.onTap,
    required this.comment,
    required this.image,
  });

  final bool isSelected;
  final String lable;
  final String comment;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 60,
              color: isSelected ? colorScheme.primary : Colors.black,
            ),
            15.sH,
            Text(
              lable,
              style: textTheme.labelMedium?.copyWith(
                fontSize: 16,
                color: isSelected ? colorScheme.primary : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _CorporateTypeButton extends StatelessWidget {
  const _CorporateTypeButton({
    required this.isSelected,
    required this.image,
    required this.lable,
    required this.onTap,
    required this.comment,
  });

  final bool isSelected;
  final String image;
  final String lable;
  final String comment;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 5),
      leading: Image.asset(
        image,
        width: 35,
        color: isSelected ? colorScheme.primary : Colors.black,
      ),
      title: Text(
        lable,
        style: textTheme.labelMedium?.copyWith(
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        comment,
        style: textTheme.labelSmall?.copyWith(
          color: Colors.grey.shade500,
          fontSize: 12,
        ),
      ),
    );
  }
}
