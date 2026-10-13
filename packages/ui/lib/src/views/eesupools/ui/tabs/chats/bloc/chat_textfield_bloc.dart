import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:flutter/material.dart';

part 'chat_textfield_event.dart';
part 'chat_textfield_state.dart';

/// Composer state: attachments and the message being replied to. Sending is
/// handled by ChatBloc so the message appears in the list instantly.
class ChatTextFieldBloc extends Bloc<ChatTextFieldEvent, ChatTextFieldState> {
  ChatTextFieldBloc()
      : super(
          ChatTextFieldCurrentState(const <File>[], null),
        ) {
    on<ChatAttachmentsPicked>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        List<File> currentFiles = [...current.files];
        currentFiles.addAll(event.files);
        final replyTo = current.replyTo;
        emit(ChatTextFieldCurrentState(currentFiles, replyTo));
      }
    });

    on<ChatMessageReplyToAdded>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        final files = current.files;
        emit(ChatTextFieldCurrentState(files, event.message));
      }
    });

    on<ChatMessageReplyToRemoved>((event, emit) {
      if (state is ChatTextFieldCurrentState) {
        final current = (state as ChatTextFieldCurrentState);
        final files = current.files;
        emit(ChatTextFieldCurrentState(files, null));
      }
    });

    on<ChatBoxReset>((event, emit) {
      emit(ChatTextFieldCurrentState(const [], null));
    });
  }
}
