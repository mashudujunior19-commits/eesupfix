import 'dart:async';
import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:data/surveys/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/features/surveys/bloc/survey_response_bloc.dart';

class OpenEndedQuestionField extends StatefulWidget {
  const OpenEndedQuestionField({super.key, required this.question});

  final Question question;

  @override
  State<OpenEndedQuestionField> createState() => _OpenEndedQuestionFieldState();
}

class _OpenEndedQuestionFieldState extends State<OpenEndedQuestionField>
    with SingleTickerProviderStateMixin {
  final record = AudioRecorder();
  bool isRecording = false;
  DateTime duration = DateTime(0);
  Timer? _timer;
  late final AnimationController animController;
  final player = AudioPlayer();
  Duration? _audioDuration;
  Duration _audioPosition = const Duration(seconds: 0, minutes: 0);

  Future<void> startRecord() async {
    if (!isRecording) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      final String appDocumentsPath = appDocumentsDir.path;

      if (await record.hasPermission()) {
        duration = DateTime(0);
        record.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path:
              '$appDocumentsPath/audio_${DateTime.now().toIso8601String()}.m4a',
        );
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            duration = duration.add(const Duration(seconds: 1));
          });
        });
        animController.repeat();

        isRecording = await record.isRecording();
        setState(() {});
      }
    }
  }

  Future<void> stopRecord() async {
    String? path = await record.stop();
    if (path != null) {
      // widget.question.recordingFile = File(path);
      // _audioDuration =
      //     await player.setFilePath(widget.question.recordingFile!.path);
    }
    _timer?.cancel();
    isRecording = await record.isRecording();
    animController.stop();

    setState(() {});
  }

  Future<void> stopAudio() async {
    await player.pause();
    setState(() {});
  }

  void seek(Duration duration) {
    player.seek(duration);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    player.positionStream.listen((event) {
      setState(() {
        _audioPosition = event;
      });
    });
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        stopAudio();
        _reset();
      }
    });

    initAudio();
  }

  void initAudio() async {
    // if (widget.question.recordingFile != null) {
    //   _audioDuration =
    //       await player.setFilePath(widget.question.recordingFile!.path);
    //   _audioDuration =
    //       await player.setFilePath(widget.question.recordingFile!.path);
    //   setState(() {});
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    player.dispose();
    animController.dispose();
  }

  Future<void> _reset() async {
    // _audioDuration = const Duration(seconds: 0, minutes: 0);
    // _audioDuration =
    //     await player.setFilePath(widget.question.recordingFile!.path);
    // setState(() {});
  }

  Future<void> playAudio() async {
    await player.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        if (!isRecording && _audioDuration != null)
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding:
                const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blueGrey.shade100,
                width: 0.9,
              ),
            ),
            child: Column(
              children: [
                ProgressBar(
                  timeLabelPadding: 5,
                  progress: _audioPosition,
                  buffered: const Duration(milliseconds: 2000),
                  total: _audioDuration!,
                  onSeek: (duration) {
                    seek(duration);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (player.playing) {
                      stopAudio();
                    } else {
                      playAudio();
                    }
                    setState(() {});
                  },
                  child: Icon(
                    player.playing
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        if (isRecording)
          Column(
            children: [
              Icon(
                MdiIcons.record,
                color: context.colorScheme.primary,
                size: 40,
              ),
              Text(
                '${duration.minute.toString().padLeft(2, '0')}:${duration.second.toString().padLeft(2, '0')}',
              ),
            ],
          ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blueGrey.shade100,
              width: 0.9,
            ),
          ),
          child: TextFormField(
            initialValue: widget.question.openEndedAnswer,
            onChanged: (va) {
              if (va.isNotEmpty) {
                context.read<SurveyResponseBloc>().add(
                      QuestionResponseUpdated(
                        widget.question.copyWith(openEndedAnswer: va),
                      ),
                    );
              } else {
                context.read<SurveyResponseBloc>().add(
                      QuestionResponseUpdated(
                        widget.question.copyWith(openEndedAnswer: null),
                      ),
                    );
              }
            },
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type your answer here',
              // suffixIcon: GestureDetector(
              //   onTap: () {
              //     if (isRecording) {
              //       stopRecord();
              //     } else {
              //       startRecord();
              //     }
              //     setState(() {});
              //   },
              //   child: Icon(
              //     isRecording ? Icons.stop : IconlyLight.voice2,
              //     color: colorScheme.primary,
              //   ),
              // ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
