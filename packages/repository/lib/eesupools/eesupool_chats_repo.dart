import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:data_sources/eesupools/models/chat_message_reaction.dart';
import 'package:data_sources/eesupools/models/eesupool_issue.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

///Just an extension to the EESUpoolRepository
///For all the chat related functions
extension EESUpoolChatsRepo on EESUpoolRepository {
  Future<Either<EESUpException, void>> reportIssue(EESUpoolIssue issue) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.reportIssue(issue);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, String?>> uploadFile(File file) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.uploadFile(file);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, void>> markIssueAsResolved(
    String issueId,
    DateTime? date,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.markIssueAsResolved(issueId, date);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, List<EESUpoolIssue>>> fetchIssues(
    int poolId,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.fetchIssues(poolId, limit);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, void>> approveMessage(int id) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.approveChatMessage(id);
      return result;
    });
    return result;
  }

  Stream<Either<EESUpException, List<ChatMessage>>> fetchEESUpoolsChatMessages(
    int poolId,
    int limit,
  ) async* {
    final stream = EESUpException.guardStream(
      action: () => dataSource.streamPoolMessages(poolId, limit),
    );
    await for (var event in stream) {
      yield event;
    }
  }

  Future<Either<EESUpException, List<ChatMessage>>> getChatMessagesByHashTag(
    int poolId,
    String tag,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      final result = dataSource.getPoolMessagesByHashTags(poolId, tag, limit);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, List<ChatMessage>>> getUnAprovedChatMessages(
    int poolId,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      final result = dataSource.getPoolMessages(poolId, limit, false);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, List<ChatMessage>>> searchEESUpoolChats(
    int poolId,
    String query,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) {
      final result = dataSource.searchPoolMessages(poolId, query, limit);
      return result;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> sendChatMessage(
    ChatMessage chatMessage,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.sendChatMessage(chatMessage);
      return result;
    });

    return result.fold((l) => Left(l), (r) => const Right(true));
  }

  Future<Either<EESUpException, bool>> addMessageReaction(
    String memberId,
    int messageId,
    bool liked,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final result = await dataSource.addChatMessageReaction(
        ChatMessageReaction(
          messageId: messageId,
          memberId: memberId,
          createdAt: DateTime.now(),
          memberName: '',
          liked: liked,
        ),
      );
      return result;
    });
    return result.fold((l) => Left(l), (r) => const Right(true));
  }

  Future<Either<EESUpException, void>> deleteChatMessage(int messageId) async {
    final result = await authRepository.executeFutureWithAuth(
      (_) => dataSource.deleteChatMessage(messageId),
    );
    return result;
  }

  Future<Either<EESUpException, void>> softDeleteChatMessage(
    int messageId,
  ) async {
    final result = await authRepository.executeFutureWithAuth(
      (_) => dataSource.softDeleteChatMessage(messageId),
    );
    return result;
  }

  Future<Either<EESUpException, void>> addMessageSeens(
    List<int> messages,
    String memberId,
  ) async {
    final result = await authRepository.executeFutureWithAuth(
      (_) => dataSource.addMessageSeens(memberId, messages),
    );
    return result;
  }
}
