import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:features/auth/profile/bloc/profile_bloc.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:repository/utils/localize_south_african_phone.dart';

@RoutePage()
// ignore: must_be_immutable
class InstapayConfirmDetailsScreen extends StatelessWidget {
  InstapayConfirmDetailsScreen({super.key, required this.transaction});
  final MerchantTransaction transaction;

  String formatPhone(String? phone) {
    if (phone == null) {
      return '';
    }
    final local = localizeSAPhoneNumber(phone);
    return local != null ? '+$local' : '';
  }

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Confirm you details'),
      ),
      body: Container(
        decoration: context.bgImage,
        child: Container(
          color: Colors.white.withOpacity(.3),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: ProfileBloc(context.read<ProfileRepository>())
              ..add(ProfileFetched()),
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const FullScreenLoadingShimmer();
              } else if (state is ProfileLoaded) {
                final profile = state.profile;
                fNameController.text = profile.firstName ?? "";
                lNameController.text = profile.lastName ?? "";
                emailController.text = profile.email ?? "";
                phone = formatPhone(phone);

                return ListView(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 500,
                    top: 20,
                  ),
                  children: [
                    const Text(
                      'Please provide the missing information',
                      textAlign: TextAlign.start,
                    ),
                    15.sH,
                    EESUpTextFormField(
                      controller: fNameController,
                      label: 'First name',
                    ),
                    EESUpTextFormField(
                      controller: lNameController,
                      label: 'Last name',
                    ),
                    EESUpTextFormField(
                      controller: emailController,
                      label: 'Email',
                    ),
                    15.sH,
                    const Text('Phone'),
                    5.sH,
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15)),
                      child: PhoneTextField(
                        initialCountry:
                            countries.firstWhere((e) => e.code == 'ZA'),
                        initialValue: phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          phone = formatPhone(value);
                        },
                      ),
                    ),
                    25.sH,
                    ElevatedButton(
                      onPressed: () {
                        if (fNameController.text.isEmpty) {
                          context.snackBarError(
                            "Your first name is required.",
                          );
                          return;
                        }
                        if (lNameController.text.isEmpty) {
                          context.snackBarError(
                            "Your last name is required.",
                          );
                          return;
                        }
                        if (emailController.text.isEmpty) {
                          context.snackBarError(
                            "Your email address is required.",
                          );
                          return;
                        }
                        if (!EmailValidator.validate(emailController.text)) {
                          context.snackBarError(
                            "Kindly enter a valid email address.",
                          );
                          return;
                        }

                        if (phone.isEmpty) {
                          context.snackBarError(
                            "Your phone is required.",
                          );
                          return;
                        }

                        context.router.push(
                          InstapayRoute(
                            transaction: transaction.copyWith(
                              bEmail: emailController.text,
                              bName: fNameController.text,
                              bSurname: lNameController.text,
                              bMobile: phone,
                            ),
                          ),
                        );
                      },
                      child: const Text("Next"),
                    )
                  ],
                );
              } else {
                return 0.sH;
              }
            },
          ),
        ),
      ),
    );
  }
}
