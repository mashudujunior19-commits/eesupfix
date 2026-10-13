import 'dart:async';

import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DmConversation {
  final String id;
  final String otherUserId;
  final String otherName;
  final String? lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  const DmConversation({
    required this.id,
    required this.otherUserId,
    required this.otherName,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });

  factory DmConversation.fromJson(Map<String, dynamic> json) => DmConversation(
        id: json['conversation_id'] as String,
        otherUserId: json['other_user_id'] as String,
        otherName: (json['other_name'] as String?) ?? 'Unknown',
        lastMessage: json['last_message'] as String?,
        lastMessageAt: DateTime.parse(json['last_message_at'] as String),
        unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      );
}

class DmMessage {
  final int id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime createdAt;
  final DateTime? readAt;
  final bool isApproved;
  final bool isDeleted;

  /// 'none' | 'held' | 'flagged' | 'approved' | 'rejected'
  final String moderationStatus;

  const DmMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.readAt,
    required this.isApproved,
    required this.isDeleted,
    required this.moderationStatus,
  });

  factory DmMessage.fromJson(Map<String, dynamic> json) => DmMessage(
        id: (json['id'] as num).toInt(),
        conversationId: json['conversation_id'] as String,
        senderId: json['sender_id'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        readAt: json['read_at'] == null
            ? null
            : DateTime.parse(json['read_at'] as String),
        isApproved: (json['is_approved'] as bool?) ?? true,
        isDeleted: (json['is_deleted'] as bool?) ?? false,
        moderationStatus: (json['moderation_status'] as String?) ?? 'none',
      );
}

class DmUser {
  final String userId;
  final String fullName;
  const DmUser({required this.userId, required this.fullName});
}

/// A message waiting in the app-admin review queue.
class HeldDm {
  final int messageId;
  final String senderName;
  final String content;
  final String status;
  final String? reason;
  final DateTime createdAt;

  const HeldDm({
    required this.messageId,
    required this.senderName,
    required this.content,
    required this.status,
    required this.reason,
    required this.createdAt,
  });

  factory HeldDm.fromJson(Map<String, dynamic> json) => HeldDm(
        messageId: (json['message_id'] as num).toInt(),
        senderName: (json['sender_name'] as String?) ?? 'Unknown',
        content: json['content'] as String,
        status: json['moderation_status'] as String,
        reason: json['moderation_reason'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}

/// One-to-one direct messages. Moderation happens in the database (a trigger
/// holds messages that match the keyword list), so every client gets it.
class DirectMessagesRepository {
  final AuthRepository _auth;
  final SupabaseClient _client;

  DirectMessagesRepository(this._auth, this._client);

  String? get currentUserId => _auth.sessionId;

  PostgrestQueryBuilder _messages() =>
      _client.schema('communities').from('dm_message');

  Future<Either<EESUpException, List<DmConversation>>>
      fetchConversations() {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client
          .schema('communities')
          .rpc('get_conversations', params: {'p_limit': 100});
      return (res as List)
          .map((e) => DmConversation.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Either<EESUpException, List<DmUser>>> searchUsers(String query) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client.schema('communities').rpc(
        'search_users_for_dm',
        params: {'p_query': query, 'p_limit': 20},
      );
      return (res as List)
          .map((e) => DmUser(
                userId: e['user_id'] as String,
                fullName: (e['full_name'] as String?) ?? 'Unknown',
              ))
          .toList();
    });
  }

  /// Finds or creates the conversation with [otherUserId].
  Future<Either<EESUpException, String>> startConversation(
      String otherUserId) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client.schema('communities').rpc(
        'start_conversation',
        params: {'p_other_user': otherUserId},
      );
      return res as String;
    });
  }

  Future<Either<EESUpException, List<DmMessage>>> fetchMessages(
    String conversationId, {
    int limit = 200,
  }) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _messages()
          .select()
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: false)
          .limit(limit);
      return (res as List)
          .map((e) => DmMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  /// Realtime messages of a conversation, newest first. Row level security
  /// already hides other people's held messages.
  Stream<List<DmMessage>> streamMessages(String conversationId) {
    return _client
        .schema('communities')
        .from('dm_message')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: false)
        .limit(200)
        .map((rows) => rows.map(DmMessage.fromJson).toList());
  }

  /// Emits whenever any of the user's direct messages change, so the
  /// conversation list can refetch.
  Stream<void> messageChanges() {
    late final StreamController<void> controller;
    RealtimeChannel? channel;
    controller = StreamController<void>(
      onListen: () {
        channel = _client
            .channel('dm_message_changes')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'communities',
              table: 'dm_message',
              callback: (_) => controller.add(null),
            )
            .subscribe();
      },
      onCancel: () async {
        final c = channel;
        if (c != null) await _client.removeChannel(c);
      },
    );
    return controller.stream;
  }

  /// Sends a message. A message that matches the moderation list comes back
  /// with isApproved == false (held for review).
  Future<Either<EESUpException, DmMessage>> sendMessage(
    String conversationId,
    String text,
  ) {
    return _auth.executeFutureWithAuth((userId) async {
      final row = await _messages()
          .insert({
            'conversation_id': conversationId,
            'sender_id': userId,
            'content': text,
          })
          .select()
          .single();
      return DmMessage.fromJson(row);
    });
  }

  Future<Either<EESUpException, void>> markRead(String conversationId) {
    return _auth.executeFutureWithAuth((_) async {
      await _client.schema('communities').rpc(
        'mark_conversation_read',
        params: {'p_conversation_id': conversationId},
      );
    });
  }

  /// The recipient reports a delivered message; it goes to the review queue.
  Future<Either<EESUpException, void>> reportMessage(
    int messageId, {
    String? reason,
  }) {
    return _auth.executeFutureWithAuth((_) async {
      await _client.schema('communities').rpc(
        'report_dm',
        params: {'p_message_id': messageId, 'p_reason': reason},
      );
    });
  }

  // App-admin review queue -------------------------------------------------

  Future<Either<EESUpException, List<HeldDm>>> fetchHeldMessages() {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client
          .schema('communities')
          .rpc('get_held_dms', params: {'p_limit': 100});
      return (res as List)
          .map((e) => HeldDm.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Either<EESUpException, void>> reviewMessage(
    int messageId, {
    required bool approve,
  }) {
    return _auth.executeFutureWithAuth((_) async {
      await _client.schema('communities').rpc(
        'review_dm',
        params: {'p_message_id': messageId, 'p_approve': approve},
      );
    });
  }

  /// Admin: pulls any message (even a delivered one) into the review queue.
  Future<Either<EESUpException, void>> flagMessage(
    int messageId, {
    String? reason,
  }) {
    return _auth.executeFutureWithAuth((_) async {
      await _client.schema('communities').rpc(
        'flag_dm',
        params: {'p_message_id': messageId, 'p_reason': reason},
      );
    });
  }
}
