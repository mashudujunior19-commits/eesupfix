import 'package:ui/src/views/surveys/ui/widgets/date_picker.dart';
import 'package:ui/src/views/surveys/ui/widgets/date_time_picker.dart';
import 'package:ui/src/views/surveys/ui/widgets/file_upload_question.dart';
import 'package:ui/src/views/surveys/ui/widgets/multiple_choice.dart';
import 'package:ui/src/views/surveys/ui/widgets/rating_scale.dart';
import 'package:ui/src/views/surveys/ui/widgets/simple_open_ended_question.dart';
import 'package:ui/src/views/surveys/ui/widgets/slider_scale.dart';
import 'package:ui/src/views/surveys/ui/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:data/surveys/models/question.dart';

///Displays the current question in a survey.
class CurrentQuestionView extends StatelessWidget {
  const CurrentQuestionView({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    ///If the time is up, show the time up widget.
    // if (timeIsUp(ref)) {
    //   return const TimeUp();
    // }

    ///Otherwise, show the question.
    return Column(
      children: [
        //const SurveyTimer(),
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
          children: [
            Text(question.question, textAlign: TextAlign.center),
            if (question.imageUrl != null)
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(question.imageUrl!, fit: BoxFit.cover),
                ),
              ),
            QuestionBody(
              question: question,
              key: ValueKey(question.questionId),
            )
          ],
        ),
      ],
    );
  }
}

class QuestionBody extends StatelessWidget {
  const QuestionBody({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return MultipleChoiceOptions(question: question);
      case QuestionType.openEnded:
        return SimpleOpenEndedQuestion(question: question);
      case QuestionType.slider:
        return SliderQuestion(question: question);
      case QuestionType.rating:
        return RatingQuestion(question: question);
      case QuestionType.fileUpload:
        return FilePickerQuestion(question: question);
      case QuestionType.date:
        return DatePicker(question: question);
      case QuestionType.time:
        return TimePicker(question: question);
      case QuestionType.dateTime:
        return DateTimePicker(question: question);
      default:
        return Container();
    }
  }
}
