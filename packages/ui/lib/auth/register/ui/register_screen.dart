import 'package:auto_route/auto_route.dart';
import 'package:ui/auth/register/bloc/registration_bloc.dart';
import 'package:ui/auth/register/ui/corporate_form.dart';
import 'package:ui/auth/register/ui/credentials_form.dart';
import 'package:ui/auth/register/ui/individual_form.dart';
import 'package:ui/auth/register/ui/referral_code_form.dart';
import 'package:ui/auth/register/ui/select_user_role.dart';
import 'package:ui/auth/register/ui/welcome_screen.dart';
import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: BlocConsumer<RegistrationBloc, RegistrationFormState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                decoration: context.bgImage,
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: _bg(),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      //Hide Back button on the welcome tab
                      leading: _tabController.index != 4
                          ? BackButton(onPressed: () {
                              if (_tabController.index == 0) {
                                Navigator.of(context).pop();
                              } else {
                                _tabController
                                    .animateTo(_tabController.index - 1);
                              }
                            })
                          : null,
                      title: _tabController.index != 4
                          ? const Text('Sign up')
                          : null,
                    ),
                    body: () {
                      if (state is SignUpForm) {
                        return TabBarView(
                          // physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            SelectUserRole(tabController: _tabController),
                            if (state.isCorp)
                              CorporateForm(
                                tabController: _tabController,
                                form: state,
                              )
                            else
                              IndividualForm(
                                tabController: _tabController,
                                form: state,
                              ),
                            CredentialsForm(
                              form: state,
                              tabController: _tabController,
                            ),
                            ReferralCodeForm(tabController: _tabController),
                            const WelcomeScreen(),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _bg() {
    return BoxDecoration(
      color: Colors.white.withOpacity(.67),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(.2),
          blurRadius: 30,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
