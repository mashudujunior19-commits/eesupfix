import 'package:data_sources/surveys/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingQuestion extends StatelessWidget {
  const RatingQuestion({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      //  padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: RatingBar.builder(
          initialRating: question.ratingValue == null
              ? 0
              : question.ratingValue!.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 40,
          unratedColor: Colors.grey.shade300,
          itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, _) => const Icon(
            IconlyBold.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // updateQuestionResponse(
            //   ref,
            //   question.copyWith(ratingValue: rating.toInt()),
            // );
          },
        ),
      ),
    );
  }
}

IconData getIcon(String iconName) {
  switch (iconName) {
    case 'Star':
      return IconlyBold.star;
    case 'Heart':
      return Icons.favorite;
    case 'Thumb up':
      return Icons.thumb_up;
    case 'Thumb down':
      return Icons.thumb_down;
    default:
      return Icons.star;
  }
}
