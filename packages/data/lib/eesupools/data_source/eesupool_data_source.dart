import 'dart:io';

import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/chat_message_reaction.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_event.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/models/eesupool_request.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/orders/models/order_product.dart';

import '../models/eesupool_settings.dart';

abstract class EESUpoolDataSource {
  ///Creates a new EESUpool, returns the id of the created EESUpool
  ///
  ///[description] is optional
  ///[parent] if the pool is meant to be a subpool
  ///[level] is the intended level of the pool
  Future<int?> createEESUpool({
    required String sessionId,
    required String name,
    String? description,
    int? parent,
    EESUpoolLevel? level,
    required EESUpoolType type,
  });

  ///Given a user id, return a list of pools that the user is a member of
  Future<dynamic> searchTradePools(
      double lat, double lng, String userId, String query, int limit);

  ///Given a user id, return a list of pools that the user is a member of
  Future<dynamic> searchPoolsByType(
      String query, String userId, EESUpoolType type, int limit);

  /// Searches all Kasi pools by name or code. [lat]/[lng] only rank nearby
  /// pools first; they never exclude any pool.
  Future<dynamic> searchKasiPools(
    String query,
    String userId,
    int limit, {
    double? lat,
    double? lng,
  });

  ///Given a user id, return a list of pools that the user is a member of
  Future<List<EESUpool>> fetchEESUpools(String sessionId, EESUpoolType type);

  Future<bool> updatePoolOrderReceivers(int orderId, List<String> memberIds);

  /// Updates the role (Receiver / Packer / Distributor) assigned to each
  /// bulk order receiver, keyed by member id.
  Future<bool> updateOrderReceiverRoles(
    int orderId,
    Map<String, ReceiverRole> roles,
  );

  ///Given a user id, return a list of pools that the user is a member of
  Future<EESUpool> fetchEESUpool(int poolId, String userId);

  ///User leaves a pool
  Future<bool> deleteMember(int poolId, String userId);

  /// Admin removal of a member. Returns null on success, otherwise the reason
  /// the removal was refused (member has a role / an incomplete order, ...).
  Future<String?> removeMember(int poolId, String userId);

  /// Why [userId] cannot be removed right now, or null when nothing blocks it.
  Future<String?> memberRemovalBlocker(int poolId, String userId);

  ///Update a given pool
  Future<void> updatePool(EESUpool pool);

  ///Get EEUSpool messages
  ///
  Future<List<ChatMessage>> getPoolMessages(
    int poolId,
    int limit,
    bool approved,
  );

  ///Get Un approved EEUSpool messages
  ///
  Future<List<ChatMessage>> getUnApprovedPoolMessages(int poolId, int limit);

  ///Get EEUSpool messages
  ///
  Future<List<ChatMessage>> getPoolMessagesByHashTags(
      int poolId, String hastTag, int limit);

  ///Streams EEUSpool messages
  ///
  Stream<List<ChatMessage>> streamPoolMessages(int poolId, int limit);

  ///Searches for EEUSpool messages
  Future<List<ChatMessage>> searchPoolMessages(
      int poolId, String query, int limit);

  ///Get EEUSpool message by id
  Future<ChatMessage> getPoolMessageById(int id);

  ///Sends a message to a given pool through the moderated server function.
  ///[plainText] is only used for the server-side moderation check;
  ///[content] is what gets stored (already encrypted).
  Future<({int id, bool isApproved, String moderationStatus})> sendChatMessage({
    required int poolId,
    required String authorId,
    required String? content,
    required String plainText,
    int? replyOnId,
    List<MediaFile>? media,
    List<String>? hashTags,
    List<EESUpoolLevel>? broadcastTo,
    required bool isApproved,
  });

  ///Upload file
  ///
  Future<String?> uploadFile(File file);

  Future<void> addChatMessageReaction(ChatMessageReaction reaction);

  ///permantly delete a message
  Future<void> deleteChatMessage(int messageId);

  ///soft delete a message
  Future<void> softDeleteChatMessage(int messageId);

  //Fetch: EESUpool members
  Future<List<EESUpoolMember>> fetchEESUpoolMembers(int poolId, int limit);

  //Update pool member
  Future<void> updatePoolMember(EESUpoolMember member);

  //report an issure
  Future<void> reportIssue(EESUpoolIssue issue);

  Future<void> markIssueAsResolved(String issueId, DateTime? date);

  Future<List<EESUpoolIssue>> fetchIssues(int poolId, int limit);

  Future<void> createEESUpoolEvent(EESUpoolEvent event);

  Future<List<EESUpoolEvent>> fetchEESUpoolEvents(int poolId, int limit);

  Future<void> updateEESUpoolEvent(EESUpoolEvent event);

  Future<void> subscribeToEvent(String eventId, String membershipId);

  Future<void> unsubscribeFromEvent(String eventId, String membershipId);

  Future<void> approveChatMessage(int messageId);

  /// Reviewer rejects a held/flagged message (it is never delivered).
  Future<void> rejectChatMessage(int messageId);

  /// Reviewer pulls an already delivered message back into the review queue.
  Future<void> flagChatMessage(int messageId, String? reason);

  Future<void> updateEvent(EESUpoolEvent event);

  Future<List<EESUpoolRequest>> fetchEESUpoolRequests({
    int? poolId,
    String? userId,
    required String type,
    required int limit,
  });

  Future<void> createEESUpoolRequest(String userId, int poolId, String type);

  Future<dynamic> searchProfilesForInvites(
      {required int poolId, required String query, required int limit});

  Future<void> deleteInviteOrRequest(String userId, int poolId);

  Future<void> updateEESUpoolRequest(String userId, int poolId, String status);

  /// Emits whenever an invite/request of the pool is inserted, updated or
  /// deleted, so listings can refetch without the user refreshing.
  Stream<void> poolRequestChanges(int poolId);

  Future<List<EESUpoolOrder>> fetchEESUpoolOrders(int poolId, int limit);
  Future<List<EESUpoolOrder>> fetchUserOpenEESUpoolOrders(String userId);
  Future<bool> createEESUpoolOrder(EESUpoolOrder order);
  Future<bool> updateEESUpoolOrder(EESUpoolOrder order);
  Future<EESUpoolSettings?> getEesupoolSettings(String userId);
  Future<bool> removeAdmin(int poolId, String userId);
  Future<bool> updateMemberCount(int poolId, String userId, num count);

  Future<EESUpoolOrder?> fetchEESUpoolOpenOrder(int poolId);

  /// Fetches a single pool order (with its aggregate member-order stats)
  /// by its own id, regardless of which pool it belongs to or whether it's
  /// still open -- used to show an individual buyer's order its parent
  /// KasiPool order's delivery date/progress.
  Future<EESUpoolOrder?> fetchEESUpoolOrderById(int orderId);

  Future<bool> joinKasi(String userId, int poolId);
  Future<dynamic> kasiStreetsSearch({
    required int parentId,
    required String userId,
    required int limit,
  });

  Future<List<EESUpool>> fetchEESUpoolDescendants({
    required int poolId,
    required String userId,
    required int limit,
  });

  Future<List<EESUpool>> searchEESUpoolDescendants({
    required String query,
    required int poolId,
    required String userId,
    required int limit,
  });

  Future<List<EESUpool>> searchUserEESUpools({
    required String query,
    required String userId,
    required EESUpoolType type,
    required int limit,
  });

  Future<bool> transferMember({
    required String memberId,
    required int newPoolId,
    required EESUpoolMemberRole role,
  });

  Future<bool> addMessageSeens(String memberId, int messageId);

  Future<int> countEESUpoolByType(String userId, EESUpoolType type);

  Future<bool> updateMemberOrderAssignments(
      List<MemberOrderAssignment> assignment, int orderId);
  Future<List<EESUpoolMember>> fetchMembersByIdList(List<String> ids);
  Future<List<OrderProduct>> fetchPoolOrderProducts(int orderId);
}
