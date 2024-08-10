import 'package:auto_route/auto_route.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/views/auth/profile/bloc/edit_profile_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src//core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/eesup_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(context.read<ProfileRepository>())
        ..add(
          EditProfileInitialized(profile),
        ),
      child: SafeArea(
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is ProfileSavingSuccess) {
              Navigator.of(context).pop();
            }

            if (state is ProfileEditingError) {
              context.snackBarError(state.error.message);
              context.read<EditProfileBloc>().add(
                    ProfileFormReset(state.profile),
                  );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const Text('Edit profile'),
              ),
              body: Container(
                decoration: context.bgImage,
                child: Container(
                  color: Colors.white.withOpacity(.4),
                  width: context.width,
                  height: context.height,
                  child: () {
                    print(state);
                    if (state is CurrentProfileForm) {
                      final profileForm = state.profile;
                      return ListView(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: 200,
                        ),
                        children: [
                          EESUpTextFormField(
                            initialValue: profile.firstName,
                            label: 'First name',
                            visible: [
                              UserRole.Ubuntunist.toString(),
                              UserRole.EESUpreneur.toString(),
                              UserRole.EESUpromoter.toString(),
                              UserRole.Driver.toString(),
                              UserRole.Spaza.toString(),
                            ].contains(profile.role.toString()),
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        firstName: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          EESUpTextFormField(
                            initialValue: profile.lastName,
                            label: 'Last name',
                            visible: [
                              UserRole.Ubuntunist.toString(),
                              UserRole.EESUpreneur.toString(),
                              UserRole.EESUpromoter.toString(),
                              UserRole.Driver.toString(),
                              UserRole.Spaza.toString(),
                            ].contains(profile.role.toString()),
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        lastName: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          Opacity(
                            opacity: profile.rsaIdNumber != null ? 0.5 : 1,
                            child: EESUpTextFormField(
                              initialValue: profile.rsaIdNumber,
                              label: 'Identity number',
                              readOnly: profile.rsaIdNumber != null,
                              type: TextInputType.number,
                              visible: [
                                UserRole.Ubuntunist.toString(),
                                UserRole.EESUpreneur.toString(),
                                UserRole.EESUpromoter.toString(),
                                UserRole.Driver.toString(),
                                UserRole.Spaza.toString(),
                              ].contains(profile.role.toString()),
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                      ProfileEdited(
                                        profileForm.copyWith(
                                          rsaIdNumber: value,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ),
                          EESUpTextFormField(
                            initialValue: profile.corpName,
                            label: 'Name',
                            visible: [
                              UserRole.Corporate.toString(),
                              UserRole.EESUpliftCorporate.toString()
                            ].contains(profile.role.toString()),
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        corpName: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          EESUpTextFormField(
                            initialValue: profile.npcReg,
                            label: 'Non-Profit reg',
                            visible:
                                profile.role == UserRole.EESUpliftCorporate,
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        npcReg: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          EESUpTextFormField(
                            initialValue: profile.corpReg,
                            label: 'Registration',
                            visible: [
                              UserRole.Corporate.toString(),
                              UserRole.EESUpliftCorporate.toString()
                            ].contains(profile.role.toString()),
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        corpReg: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          EESUpTextFormField(
                            initialValue: profile.corpVatNo,
                            label: 'VAT number',
                            visible: [
                              UserRole.Corporate.toString(),
                              UserRole.EESUpliftCorporate.toString()
                            ].contains(profile.role.toString()),
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        corpVatNo: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          15.sH,
                          EESUpTextFormField(
                            initialValue: profile.role.toString(),
                            label: 'Role',
                            readOnly: true,
                          ),
                          EESUpTextFormField(
                            initialValue: profile.email,
                            label: 'Email',
                            readOnly: true,
                            onChanged: (value) {
                              context.read<EditProfileBloc>().add(
                                    ProfileEdited(
                                      profileForm.copyWith(
                                        email: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          if (state.pendingEmailVerification(profile.email))
                            TextButton(
                              onPressed: () {},
                              child: const Text('Verify email'),
                            ),
                          AbsorbPointer(
                            absorbing: true,
                            child: EESUpPhoneTextField(
                              onChanged: (phone) {
                                context.read<EditProfileBloc>().add(
                                      ProfileEdited(
                                        profileForm.copyWith(
                                          phone: phone,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ),
                          if (state.pendingPhoneVerification(profile.phone))
                            TextButton(
                              onPressed: () {
                                // context.showBottomSheetDialog(
                                //   child: OtpAuthDialog(
                                //     type: OtpType.sms,
                                //     phone: profileForm.phone,
                                //   ),
                                // );

                                // context.read<EditProfileBloc>().add(
                                //       PhoneVerificationStarted(profileForm),
                                //     );
                              },
                              child: const Text('Verify phone'),
                            ),
                          if (profileForm != profile)
                            ElevatedButton(
                              onPressed: () {
                                context.read<EditProfileBloc>().add(
                                      ProfileSaved(profile.rsaIdNumber),
                                    );
                              },
                              child: const Text('Save changes'),
                            ),
                        ],
                      );
                    } else {
                      return 0.sW;
                    }
                  }(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
