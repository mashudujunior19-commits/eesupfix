import 'package:data/surveys/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ResponseNavButton extends StatelessWidget {
  const ResponseNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
      child: Row(
        children: [
          //if (index(ref) > 0)
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 115,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
              ),
              onPressed: () {
                //decrementIndex(ref);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(IconlyLight.arrowLeft),
                  Text('  Back'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // //FocusScope.of(context).unfocus();
                // final question = notifierQuestion(ref);
                // if (canProcced(question)) {
                //   incrementIndex(ref, maxIndex(ref));
                // } else {
                //   showSnackBar(
                //     context: context,
                //     message: 'This question is required.',
                //     type: SnackBarType.error,
                //   );
                // }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(IconlyLight.arrowRight),
                  Text('  Next'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool canProcced(Question? question) {
    if (question == null) return false;

    if (!question.isRequired) {
      return true;
    }

    if (question.type == QuestionType.multipleChoice) {
      return question.choices!.any((element) => element.isSelected);
    } else if (question.type == QuestionType.openEnded) {
      return question.openEndedAnswer != null &&
          question.openEndedAnswer!.isNotEmpty;
    } else if (question.type == QuestionType.slider) {
      return question.sliderValue != null;
    } else if (question.type == QuestionType.rating) {
      return question.ratingValue != null;
    } else if (question.type == QuestionType.fileUpload) {
      return question.pickedfiles != null && question.pickedfiles!.isNotEmpty;
    } else if (question.type == QuestionType.date) {
      return question.pickedDate != null;
    } else if (question.type == QuestionType.time) {
      return question.timePicked != null;
    } else if (question.type == QuestionType.dateTime) {
      return question.dateTimePicked != null;
    } else {
      return false;
    }
  }
}
