import 'dart:io';

import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:data_sources/eesupools/models/chat_message_reaction.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:data_sources/eesupools/models/eesupool_event.dart';
import 'package:data_sources/eesupools/models/eesupool_issue.dart';
import 'package:data_sources/eesupools/models/eesupool_level.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:data_sources/eesupools/models/eesupool_request.dart';
import 'package:data_sources/eesupools/models/eesupool_type.dart';

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

  ///Given a user id, return a list of pools that the user is a member of
  Future<List<EESUpool>> fetchEESUpools(String sessionId, EESUpoolType type);

  ///Given a user id, return a list of pools that the user is a member of
  Future<EESUpool> fetchEESUpool(int poolId, String userId);

  ///User leaves a pool
  Future<bool> deleteMember(int poolId, String userId);

  ///Update a given pool
  Future<void> updatePool(EESUpool pool);

  ///Get EEUSpool messages
  ///
  Future<List<ChatMessage>> getPoolMessages(
    int poolId,
    int limit,
    bool approved,
  );

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

  ///Sends a message to a given pool
  Future<void> sendChatMessage(ChatMessage message);

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

  Future<List<EESUpoolOrder>> fetchEESUpoolOrders(int poolId, int limit);
  Future<List<EESUpoolOrder>> fetchUserOpenEESUpoolOrders(String userId);
  Future<bool> createEESUpoolOrder(EESUpoolOrder order);
  Future<bool> updateEESUpoolOrder(EESUpoolOrder order);

  Future<EESUpoolOrder?> fetchEESUpoolOpenOrder(int poolId);

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
}
