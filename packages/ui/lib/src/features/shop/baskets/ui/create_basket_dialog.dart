import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';



class CreateBasketDialog extends StatelessWidget {
  CreateBasketDialog({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.sizeOf(context).height * .20,
          bottom: MediaQuery.sizeOf(context).height * .40,
          left: 20,
          right: 20,
        ),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Create Basket'),
          ),
          body: ListView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            children: [
              EESUpTextFormField(
                label: "Name",
                hintText: "My Monthly groceries",
                controller: controller,
              ),
              25.sH,
              ElevatedButton(
                onPressed: () async {
                  // if (controller.text.isNotEmpty) {
                  //   context.loaderOverlay.show();

                  //   final success =
                  //       await ref.read(shoppingRepoProvider).createBasket(
                  //             controller.text,
                  //           );

                  //   if (context.mounted) {
                  //     context.loaderOverlay.hide();
                  //   }

                  //   success.fold((l) {
                  //     showSnackBar(
                  //       context: context,
                  //       message: l.message,
                  //       type: SnackBarType.error,
                  //     );
                  //   }, (r) {
                  //     showSnackBar(
                  //       context: context,
                  //       message: "Basket created successfully",
                  //       type: SnackBarType.success,
                  //     );
                  //     Navigator.pop(context);
                  //   });
                  // } else {
                  //   showSnackBar(
                  //     context: context,
                  //     message: "Enter the name of your basket",
                  //     type: SnackBarType.error,
                  //   );
                  // }
                },
                child: const Text("Create"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
