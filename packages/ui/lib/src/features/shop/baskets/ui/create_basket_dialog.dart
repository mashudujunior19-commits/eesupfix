import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

class CreateBasketDialog extends StatelessWidget {
  CreateBasketDialog({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (controller.text.isEmpty) {
                context.snackBarError("Enter the name of your basket");
                return;
              }
              context.loaderOverlay.show();
              final repo = context.read<ShoppingRepository>();
              final success = await repo.createBasket(
                controller.text,
              );
        
              if (context.mounted) {
                context.loaderOverlay.hide();
              }
        
              success.fold((l) {
                context.snackBarError(l.message);
              }, (r) {
                context.snackBarSuccess("Basket created successfully");
                Navigator.pop(context);
              });
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }
}
