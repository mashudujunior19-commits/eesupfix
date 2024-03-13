import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/eesupools/models/media_file.dart';
import 'package:eesup_data_source/surveys/data_source/survey_data_source.dart';
import 'package:eesup_data_source/surveys/models/survey.dart';
import 'package:eesup_data_source/surveys/models/survey_response.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';

class SurveyRepository {
  final SurveyDataSource _surveyDs;
  final AuthRepository _authRepo;

  SurveyRepository(this._surveyDs, this._authRepo);

  Future<Either<EESUpException, List<Survey>>> fetchSurveys(
    SurveyType type,
  ) async {
    final result = await _authRepo.executeFutureWithAuth((id) async {
      final surveys = await _surveyDs.fetchSurveys(id, type);
      return surveys;
    });
    return result;
  }

  Future<Either<EESUpException, String?>> submitSurveyResponse(
    Survey survey,
  ) async {
    final result = await _authRepo.executeFutureWithAuth((id) async {
      //uploading files first and ge the urls
      List<QuestionAnswer> questionAnswers = [];
      for (final q in survey.questions) {
        final files = await _uploadFiles(q.pickedfiles ?? []);
        questionAnswers.add(
          QuestionAnswer(
              questionId: q.questionId,
              sliderValue: q.sliderValue,
              ratingValue: q.ratingValue,
              openEndedAnswer: q.openEndedAnswer,
              recordingUrl: q.recordingUrl,
              files: files,
              dateTime: q.dateTimePicked,
              date: q.pickedDate,
              time: q.timePicked),
        );
      }

      final response = SurveyResponse(
        userId: id,
        surveyId: survey.id,
        score: 0,
        passed: false,
        answers: questionAnswers,
      );

      ///save survey response
      final res = await _surveyDs.saveResponse(response);

      return res;
    });

    return result;
  }

  Future<List<MediaFile>> _uploadFiles(List<File> files) async {
    List<MediaFile> media = [];
    for (final file in files) {
      final type = file.path.split('.').last;
      final name = file.path.split('/').last;
      final url = await _surveyDs.uploadFile(name, file);
      if (url != null) {
        media.add(MediaFile(url: url, type: type, name: name));
      }
    }
    return media;
  }
}
