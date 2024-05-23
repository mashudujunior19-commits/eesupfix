import 'package:data/shopping/models/product_request.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

class ProductRequestFormDialog extends StatelessWidget {
  ProductRequestFormDialog({super.key});
  final brandController = TextEditingController();
  final typeController = TextEditingController();
  final packSizeController = TextEditingController();
  final variantController = TextEditingController();
  final productQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('New Request'),
        actions: [
          TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (typeController.text.isEmpty ||
                  brandController.text.isEmpty ||
                  packSizeController.text.isEmpty) {
                context.snackBarError("Please fill all required fields(*)");
                return;
              }

              context.loaderOverlay.show();
              final repo = context.read<ShoppingRepository>();
              final results = await repo.createRequest(
                ProductRequest(
                  id: 0,
                  userId: '',
                  packSize: packSizeController.text,
                  type: typeController.text,
                  brand: brandController.text,
                  variant: variantController.text.isEmpty
                      ? null
                      : variantController.text,
                  quantity: int.parse(productQuantityController.text),
                ),
              );
              context.loaderOverlay.hide();

              results.fold((l) {
                context.snackBarError(l.message);
              }, (r) {
                context.snackBarSuccess("Request submitted successfully");
                Navigator.pop(context);
              });
            },
            child: const Text("Submit"),
          ),
          15.sW,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 23,
          right: 23,
          bottom: 400,
          top: 20,
        ),
        children: [
          const Text('Can\'t find your product? Request it here!'),
          20.sH,
          EESUpTextFormField(
            label: 'Product type',
            hintText: 'Air freshener',
            controller: typeController,
            isRequired: true,
          ),
          EESUpTextFormField(
            label: 'Brand',
            hintText: 'Airwick',
            controller: brandController,
            isRequired: true,
          ),
          EESUpTextFormField(
            label: 'Pack size',
            hintText: '280ml',
            isRequired: true,
            controller: packSizeController,
          ),
          EESUpTextFormField(
            label: 'Variant',
            hintText: 'Lavender',
            controller: variantController,
          ),
          EESUpTextFormField(
            label: 'Quantity',
            hintText: '10',
            controller: productQuantityController,
            type: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
