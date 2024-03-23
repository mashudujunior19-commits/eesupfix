import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:data_sources/eesupools/models/eesupool_level.dart';
import 'package:data_sources/eesupools/models/media_file.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_chats_repo.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'chat_textfield_event.dart';
part 'chat_textfield_state.dart';

class ChatTextFieldBloc extends Bloc<ChatTextFieldEvent, ChatTextFieldState> {
  final EESUpoolRepository _eeupoolsRepo;

  ChatTextFieldBloc(this._eeupoolsRepo)
      : super(
          ChatTextFieldCurrentState(const <File>[], null),
        ) {
    on<ChatAttachmentsPicked>((event, emit) {
      final current = (state as ChatTextFieldCurrentState);
      List<File> currentFiles = [...current.files];
      currentFiles.addAll(event.files);
      final replyTo = current.replyTo;

      emit(ChatTextFieldCurrentState(currentFiles, replyTo));
    });

    on<ChatMessageReplyToAdded>((event, emit) {
      final current = (state as ChatTextFieldCurrentState);
      final files = current.files;

      emit(ChatTextFieldCurrentState(files, event.message));
    });

    on<ChatMessageSent>((event, emit) async {
      if (state is ChatTextFieldCurrentState) {
        emit(ChatLoading());
        final message = (state as ChatTextFieldCurrentState);
        final results = await _sendMessage(
          event.pool.memberId!,
          event.pool.eesupoolId!,
          event.text,
          event.pool.chatTagsSuggestions ?? [],
          event.pool.isCensored ?? false,
          event.broadcastTo ?? [],
          message.files,
          message.replyTo,
        );

        results.fold((l) {}, (r) {});
      }
    });
  }

  Future<Either<EESUpException, bool>> _sendMessage(
    String memberId,
    int poolId,
    String message,
    List<String> tags,
    bool isApproved,
    List<EESUpoolLevel>? broadcastTo,
    List<File> files,
    ChatMessage? replyTo,
  ) async {
    final List<MediaFile> mediaFiles = [];

    for (final file in files) {
      final result = await _eeupoolsRepo.uploadFile(file);
      result.fold((ex) {
        return Left(ex);
      }, (url) {
        if (url != null) {
          mediaFiles.add(
            MediaFile(
              url: url,
              type: file.path.split('.').last,
              name: file.path.split('/').last,
            ),
          );
        }
      });
    }

    final inharitedTags = replyTo?.hashTags ?? [];
    final newTags = [..._findTagsInMessage(tags, message)];
    for (final tag in inharitedTags) {
      if (!newTags.contains(tag)) {
        newTags.add(tag);
      }
    }

    final result = await _eeupoolsRepo.sendChatMessage(
      ChatMessage(
        id: 1,
        eesupoolId: poolId,
        authorId: memberId,
        replyOnId: replyTo?.id,
        createdAt: DateTime.now(),
        content: message.isEmpty ? null : message,
        media: mediaFiles,
        isApproved: isApproved,
        hashTags: newTags,
        isDeleted: false,
        broadcastTo: broadcastTo,
      ),
    );

    return result;
  }

  List<String> _findTagsInMessage(List<String> tags, String message) {
    List<String> foundTags = [];

    for (String tag in tags) {
      if (message.contains(tag)) {
        foundTags.add(tag);
      }
    }

    return foundTags;
  }
}
