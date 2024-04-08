import 'package:auto_route/auto_route.dart';
import 'package:data_sources/auth/models/profile.dart';
import 'package:features/auth/profile/bloc/profile_bloc.dart';
import 'package:features/core/extensions/bottom_sheet_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:instapay_flutter/presentation/instapay.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repository/auth/profile_repository.dart';
import 'user_details_dialog.dart';

@RoutePage()
// ignore: must_be_immutable
class InstapayScreen extends StatelessWidget {
  const InstapayScreen({super.key, required this.transaction});
  final MerchantTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: ProfileBloc(context.read<ProfileRepository>())
        ..add(ProfileFetched()),
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is ProfileLoaded) {
          final profile = state.profile;

          if (profile.email == null ||
              profile.phone == null ||
              profile.firstName == null ||
              profile.lastName == null) {
            context
                .showCustomDialog(
              isDismissable: false,
              child: UserDetailsDialog(prfile: profile),
            )
                .then((value) {
              if (value != null) {
                context.read<ProfileBloc>().add(ProfileFetched());
              }
            });
          }
        }
      },
      builder: (context, state) {
        Profile? profile;

        if (state is ProfileLoaded) {
          profile = state.profile;
        }

        if (profile?.email == null ||
            profile?.phone == null ||
            profile?.firstName == null ||
            profile?.lastName == null) {
          return Scaffold(
            appBar: _appBar(context),
          );
        } else {
          return Scaffold(
            appBar: _appBar(context),
            body: InstapayFlutter(
              transaction: transaction.copyWith(
                bEmail: profile?.email,
                bMobile: profile?.phone,
                bName: profile?.firstName,
                bSurname: profile?.lastName,
              ),
              onUrlChange: (String? url) {
                if (url != null) {
                  if (url.contains('payment_success')) {
                    Navigator.of(context).pop(true);
                  } else if (url.contains('payment_failed')) {
                    Navigator.of(context).pop(false);
                  }
                }
              },
            ),
          );
        }
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      title: const Text("Instapay"),
    );
  }
}
