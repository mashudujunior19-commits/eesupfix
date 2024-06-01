import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:either_dart/either.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

class SearchTransferBeneficiaryDialog extends StatefulWidget {
  const SearchTransferBeneficiaryDialog({super.key});

  @override
  State<SearchTransferBeneficiaryDialog> createState() =>
      SearchTransferBeneficiaryDialogState();
}

class SearchTransferBeneficiaryDialogState
    extends State<SearchTransferBeneficiaryDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          top: context.height * .2,
        ),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Transform.scale(
              scale: .95,
              child: EESUpTextFormField(
                hintText: 'Search referral code, first name, last name...',
                readOnly: false,
                controller: _controller,
                type: TextInputType.text,
                onChanged: (v) {
                  setState(() {});
                },
              ),
            ),
          ),
          body: FutureBuilder<Either<EESUpException, List<dynamic>>>(
            future: context
                .read<WalletsRepository>()
                .searchTransferBeneficiary(_controller.text),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final found = snapshot.data!;
                return found.fold((left) {
                  return Center(child: FullScreenError(exception: left));
                }, (right) {
                  return ListView.builder(
                    itemCount: right.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              context.colorScheme.primary.withOpacity(
                            .5,
                          ),
                          child: const Icon(
                            BootstrapIcons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          right[index]['full_name'] ??
                              right[index]['corp_name'],
                        ),
                        subtitle: Text(
                          right[index]['description'] + ' wallet',
                        ),
                        trailing: const Icon(
                          IconlyLight.arrowRight2,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.pop(context, right[index]);
                        },
                      );
                    },
                  );
                });
              } else {
                return 0.sW;
              }
            },
          ),
        ),
      ),
    );
  }
}
