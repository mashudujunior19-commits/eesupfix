import 'package:flutter/material.dart';

class ResponseSubmitButton extends StatelessWidget {
  const ResponseSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
      child: ElevatedButton(
        onPressed: () async {
          // context.loaderOverlay.show();
          // final res = await submit(ref);
          // if (context.mounted) {
          //   context.loaderOverlay.hide();
          // }
          // res.fold((l) {
          //   showSnackBar(
          //     context: context,
          //     message: l.message,
          //     type: SnackBarType.error,
          //   );
          // }, (r) {
          //   showSnackBar(
          //     context: context,
          //     message: 'Survey submitted successfully',
          //     type: SnackBarType.success,
          //   );
          //   resetSurvey(ref);
          //   Navigator.of(context).pop(r);
          // });
        },
        child: const Text('Submit'),
      ),
    );
  }
}
