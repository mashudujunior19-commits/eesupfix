import 'package:data/auth/repository/profile_repository.dart';
import 'package:ui/src/features/auth/profile/bloc/profile_bloc.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';

class ReferalCodeTile extends StatelessWidget {
  const ReferalCodeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: ProfileBloc(context.read<ProfileRepository>())
        ..add(ProfileFetched()),
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 30,
              bottom: 10,
            ),
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HighlightedText(
                    'Referral Code  '
                    '${state.profile.referralCode.toString()}',
                    patterns: const [r'[0-9]'],
                    style: context.textTheme.labelMedium,
                    highLightStyle: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: state.profile.referralCode.toString(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  content: const Text("Copied to clipboard"),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return 0.sW;
        }
      },
    );
  }
}
