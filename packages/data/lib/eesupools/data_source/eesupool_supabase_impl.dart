import 'dart:io';
import 'package:data/eesupools/data_source/eesupool_data_source.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/chat_message_reaction.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_event.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/eesupool_request.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EESUpoolSupabaseImp implements EESUpoolDataSource {
  final SupabaseClient client;
  EESUpoolSupabaseImp({required this.client});

  @override
  Future<int?> createEESUpool({
    required String sessionId,
    required String name,
    String? description,
    int? parent,
    EESUpoolLevel? level,
    required EESUpoolType type,
  }) async {
    final response =
        await client.schema('communities').rpc('create_new_eesupool', params: {
      'admin_id': sessionId,
      'name': name,
      'description': description,
      'level': level?.toString(),
      'parent_id': parent,
      'type': type.toString(),
    });
    return response;
  }

  @override
  Future<bool> deleteMember(int poolId, String userId) async {
    try {
      await client
          .schema('communities')
          .from('eesupool_member')
          .delete()
          .eq('user_id', userId)
          .eq('eesupool_id', poolId);
      await client
          .schema('communities')
          .from('eesupool_request')
          .delete()
          .eq('user_id', userId)
          .eq('eesupool_id', poolId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> updatePool(EESUpool pool) async {
    await client
        .schema('communities')
        .from('eesupool')
        .update(pool.toJson())
        .eq('id', pool.eesupoolId ?? 0);
  }

  @override
  Future<List<EESUpool>> fetchEESUpools(
    String sessionId,
    EESUpoolType type,
  ) async {
    final res = await client.schema('communities').rpc(
      'get_user_eesupools_v2',
      params: {
        'id': sessionId,
        'limit_to': 100,
        'pool_type': type.toString(),
      },
    );
    return (res as List).map((e) => EESUpool.fromJson(e)).toList();
  }

  @override
  Future<List<ChatMessage>> getPoolMessages(
    int poolId,
    int limit,
    bool approved,
  ) async {
    final res = await client.schema('communities').rpc('get_eesupool_messages',
        params: {'pool_id': poolId, 'limit_to': limit});

    List<ChatMessage> list =
        (res as List).map((e) => ChatMessage.fromJson(e)).toList();
    return list;
  }

  @override
  Future<List<ChatMessage>> getUnApprovedPoolMessages(
      int poolId, int limit) async {
    final res = await client
        .schema('communities')
        .rpc('get_eesupool_messages',
            params: {'pool_id': poolId, 'limit_to': limit})
        .eq('is_approved', false)
        .eq('is_deleted', false);

    List<ChatMessage> list =
        (res as List).map((e) => ChatMessage.fromJson(e)).toList();
    return list;
  }

  @override
  Future<ChatMessage> getPoolMessageById(int id) async {
    final res =
        await client.schema('communities').rpc('get_message_by_id', params: {
      'm_id': id,
    }).single();
    return ChatMessage.fromJson(res);
  }

  @override
  Stream<List<ChatMessage>> streamPoolMessages(int poolId, int limit) async* {
    final stream = client
        .schema('communities')
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('eesupool_id', poolId)
        .limit(1);
    // ignore: unused_local_variable
    await for (final event in stream) {
      final pools = getPoolMessages(poolId, limit, true);
      yield await pools;
    }
  }

  @override
  Future<void> sendChatMessage(ChatMessage message) async {
    await client.schema('communities').from('message').insert(message.toJson());
  }

  @override
  Future<String?> uploadFile(File file) async {
    final path = '${DateTime.now().millisecondsSinceEpoch.toString()}.png';
    const options = FileOptions(cacheControl: '3600', upsert: false);
    await client.storage
        .from('message_attachments')
        .upload(path, file, fileOptions: options);

    final url = client.storage.from('message_attachments').getPublicUrl(path);
    return url;
  }

  @override
  Future<List<ChatMessage>> searchPoolMessages(
      int poolId, String query, int limit) async {
    final res = await client.rpc('search_eesupool_chat_messages', params: {
      'pool_id': poolId,
      'query': query,
      'limit_to': limit,
    });
    List<ChatMessage> list =
        (res as List).map((e) => ChatMessage.fromJson(e)).toList();
    return list;
  }

  @override
  Future<void> addChatMessageReaction(ChatMessageReaction reaction) async {
    await client.schema('communities').rpc('add_or_delete_reaction', params: {
      '_message_id': reaction.messageId,
      '_member_id': reaction.memberId,
      '_liked': reaction.liked,
    });
  }

  @override
  Future<List<ChatMessage>> getPoolMessagesByHashTags(
      int poolId, String hastTag, int limit) async {
    final res = await client
        .schema('communities')
        .rpc('get_eesupool_messages_by_hash_tag', params: {
      'pool_id': poolId,
      'limit_to': limit,
      'hash_tag': hastTag,
    });

    List<ChatMessage> list =
        (res as List).map((e) => ChatMessage.fromJson(e)).toList();
    return list;
  }

  @override
  Future<EESUpool> fetchEESUpool(int poolId, String userId) async {
    final res = await client.rpc('get_eesupool_by_id', params: {
      '_user_id': userId,
      '_pool_id': poolId,
    }).single();
    return EESUpool.fromJson(res);
  }

  @override
  Future<void> deleteChatMessage(int messageId) async {
    await client
        .schema('communities')
        .from('message')
        .delete()
        .eq('id', messageId);
  }

  @override
  Future<void> softDeleteChatMessage(int messageId) async {
    await client
        .schema('communities')
        .from('message')
        .update({'is_deleted': true}).eq('id', messageId);
  }

  @override
  Future<List<EESUpoolMember>> fetchEESUpoolMembers(
    int poolId,
    int limit,
  ) async {
    final result =
        await client.schema('communities').rpc('get_eesupool_members', params: {
      'pool_id': poolId,
      'limit_to': limit,
    });
    return (result as List).map((e) => EESUpoolMember.fromJson(e)).toList();
  }

  @override
  Future<void> updatePoolMember(EESUpoolMember member) async {
    await client
        .schema('communities')
        .from('eesupool_member')
        .update(member.toJson())
        .eq('id', member.memberId);
  }

  @override
  Future<List<EESUpoolIssue>> fetchIssues(int poolId, int limit) async {
    final result =
        await client.schema('communities').rpc('get_eesupool_issues', params: {
      'pool_id': poolId,
      'limit_to': limit,
    });
    return (result as List).map((e) => EESUpoolIssue.fromJson(e)).toList();
  }

  @override
  Future<void> markIssueAsResolved(String issueId, DateTime? date) async {
    await client
        .schema('communities')
        .from('eesupool_issue')
        .update({'resolved_at': date?.toIso8601String()}).eq('id', issueId);
  }

  @override
  Future<void> reportIssue(EESUpoolIssue issue) async {
    await client
        .schema('communities')
        .from('eesupool_issue')
        .insert(issue.toJson());
  }

  @override
  Future<void> createEESUpoolEvent(EESUpoolEvent event) async {
    await client.schema('communities').from('event').insert(event.toJson());
  }

  @override
  Future<List<EESUpoolEvent>> fetchEESUpoolEvents(int poolId, int limit) async {
    final result =
        await client.schema('communities').rpc('get_eesupool_events', params: {
      'pool_id': poolId,
    });
    return (result as List).map((e) => EESUpoolEvent.fromJson(e)).toList();
  }

  @override
  Future<void> updateEESUpoolEvent(EESUpoolEvent event) async {
    await client
        .schema('communities')
        .from('event')
        .update(event.toJson())
        .eq('id', event.id);
  }

  @override
  Future<void> subscribeToEvent(String eventId, String membershipId) async {
    await client.schema('communities').from('event_attendee').insert({
      'event_id': eventId,
      'member_id': membershipId,
    });
  }

  @override
  Future<void> unsubscribeFromEvent(String eventId, String membershipId) async {
    await client
        .schema('communities')
        .from('event_attendee')
        .delete()
        .eq('event_id', eventId)
        .eq('member_id', membershipId);
  }

  @override
  Future<void> approveChatMessage(int messageId) async {
    await client.schema('communities').from('message').update({
      'is_approved': true,
    }).eq('id', messageId);
  }

  @override
  Future<void> updateEvent(EESUpoolEvent event) async {
    await client
        .schema('communities')
        .from('event')
        .update(event.toJson())
        .eq('id', event.id);
  }

  @override
  Future<List<EESUpoolRequest>> fetchEESUpoolRequests({
    int? poolId,
    String? userId,
    required String type,
    required int limit,
  }) async {
    final res = await client
        .schema('communities')
        .rpc('get_eesupool_requests_and_invites', params: {
      'pool_id': poolId,
      'p_user_id': userId,
      'p_type': type,
      'limit_to': limit,
    });

    return (res as List).map((e) => EESUpoolRequest.fromJson(e)).toList();
  }

  @override
  Future<dynamic> searchProfilesForInvites({
    required int poolId,
    required String query,
    required int limit,
  }) async {
    final results = await client
        .schema('communities')
        .rpc('search_profiles_for_eesupool_invites', params: {
      'pool_id': poolId,
      'query_str': query,
      'limit_to': limit,
    });

    return results;
  }

  @override
  Future<void> createEESUpoolRequest(
    String userId,
    int poolId,
    String type,
  ) async {
    await client.schema('communities').from('eesupool_request').insert({
      'user_id': userId,
      'eesupool_id': poolId,
      'type': type,
    });
  }

  @override
  Future<void> deleteInviteOrRequest(String userId, int poolId) async {
    await client
        .schema('communities')
        .from('eesupool_request')
        .delete()
        .eq('user_id', userId)
        .eq('eesupool_id', poolId);
  }

  @override
  Future<void> updateEESUpoolRequest(
      String userId, int poolId, String status) async {
    try {
      await client
          .schema('communities')
          .from('eesupool_request')
          .update({'status': status})
          .eq('user_id', userId)
          .eq('eesupool_id', poolId);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> createEESUpoolOrder(EESUpoolOrder order) async {
    try {
      Map<String, dynamic> ord = order.toJson();
      ord.addAll(
        {'receivers': order.receivers?.map((e) => e.memberId).toList()},
      );
      await client.schema('communities').from('eesupool_order').insert(ord);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<EESUpoolOrder>> fetchEESUpoolOrders(int poolId, int limit) async {
    final res = await client.schema('communities').rpc(
      'get_eesupool_orders',
      params: {
        'pool_id': poolId,
        'limit_to': limit,
      },
    );
    return (res as List).map((e) => EESUpoolOrder.fromJson(e)).toList();
  }

  @override
  Future<List<EESUpoolOrder>> fetchUserOpenEESUpoolOrders(String userId) async {
    final res = await client.schema('communities').rpc(
      'get_open_eesupool_orders',
      params: {'_user_id': userId, '_eesupool_id': null, '_limit_to': 500},
    );
    return (res as List).map((e) => EESUpoolOrder.fromJson(e)).toList();
  }

  @override
  Future<bool> updateEESUpoolOrder(EESUpoolOrder order) async {
    try {
      print(order.toJson());
      await client
          .schema('communities')
          .from('eesupool_order')
          .update(order.toJson())
          .eq('id', order.id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<dynamic> searchPoolsByType(
    String query,
    String userId,
    EESUpoolType type,
    int limit,
  ) async {
    final res = await client.schema('communities').rpc(
      'search_for_eesupools_by_type',
      params: {
        'query_str': query,
        '_user_id': userId,
        '_type': type.toString(),
        'limit_to': limit,
      },
    );

    return res;
  }

  @override
  Future<dynamic> searchTradePools(
      double lat, double lng, String userId, String query, int limit) async {
    final res = await client.schema('communities').rpc(
      'search_for_trade_eesupools',
      params: {
        'query_str': query,
        '_user_id': userId,
        'limit_to': limit,
        'lat': lat,
        'lng': lng,
      },
    ).order('distance', ascending: true);

    return res;
  }

  @override
  Future<bool> joinKasi(String userId, int poolId) async {
    try {
      await client.schema('communities').from('eesupool_member').insert({
        'user_id': userId,
        'eesupool_id': poolId,
        'role': EESUpoolMemberRole.member.toString(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future kasiStreetsSearch({
    required int parentId,
    required String userId,
    required int limit,
  }) async {
    final res = await client.schema('communities').rpc(
      'get_eesupools_descendants_streets_for_requests',
      params: {
        'parent_pool_id': parentId,
        '_user_id': userId,
        'limit_to': limit,
      },
    ).order('name', ascending: true);

    return res;
  }

  @override
  Future<List<EESUpool>> fetchEESUpoolDescendants({
    required int poolId,
    required String userId,
    required int limit,
  }) async {
    final res = await client
        .schema('communities')
        .rpc('get_eesupools_descendants', params: {
      '_user_id': userId,
      'parent_pool_id': poolId,
      'limit_to': limit
    });
    return (res as List).map((e) => EESUpool.fromJson(e)).toList();
  }

  @override
  Future<List<EESUpool>> searchEESUpoolDescendants({
    required String query,
    required int poolId,
    required String userId,
    required int limit,
  }) async {
    final res = await client
        .schema('communities')
        .rpc('search_eesupools_descendants', params: {
      '_user_id': userId,
      'parent_pool_id': poolId,
      'limit_to': limit,
      'query_str': query,
    });
    return (res as List).map((e) => EESUpool.fromJson(e)).toList();
  }

  @override
  Future<bool> transferMember(
      {required String memberId,
      required int newPoolId,
      required EESUpoolMemberRole role}) async {
    try {
      await client.schema('communities').from('eesupool_member').update({
        'eesupool_id': newPoolId,
        'role': role.toString(),
      }).eq(
        'id',
        memberId,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> addMessageSeens(String memberId, int messageId) async {
    try {
      await client
          .schema('communities')
          .from('message_seen')
          .insert({'message_id': messageId, 'member_id': memberId});
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('====>$e<=====');
      }
      return false;
    }
  }

  @override
  Future<List<EESUpool>> searchUserEESUpools({
    required String query,
    required String userId,
    required EESUpoolType type,
    required int limit,
  }) async {
    final res = await client
        .schema('communities')
        .rpc('search_user_eesupools', params: {
      '_user_id': userId,
      'query_str': query,
      '_type': type.toString(),
      'limit_to': limit,
    });
    return (res as List).map((e) => EESUpool.fromJson(e)).toList();
  }

  @override
  Future<int> countEESUpoolByType(String userId, EESUpoolType type) async {
    final count = await client.schema('communities').rpc(
        'count_user_eesupools_by_type',
        params: {'_id': userId, '_type': type.toString()});
    return count;
  }

  @override
  Future<EESUpoolOrder?> fetchEESUpoolOpenOrder(int poolId) async {
    try {
      final order = await client
          .schema('communities')
          .rpc('get_open_eesupool_order', params: {'pool_id': poolId}).single();
      return EESUpoolOrder.fromJson(order);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateMemberOrderAssignments(
    List<MemberOrderAssignment> assignment,
    int orderId,
  ) async {
    try {
      await client
          .schema('communities')
          .from('member_order_assignment')
          .delete()
          .eq('order_id', orderId)
          .whenComplete(() async {
        await client
            .schema('communities')
            .from('member_order_assignment')
            .insert(
              assignment.map((e) => e.toJson()).toList(),
            );
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<List<EESUpoolMember>> fetchMembersByIdList(List<String> ids) async {
    final results = await client.schema('communities').rpc(
        'get_eesupool_members_by_id_array',
        params: {'members': ids.toList()});
    return (results as List).map((e) => EESUpoolMember.fromJson(e)).toList();
  }

  @override
  Future<bool> updatePoolOrderReceivers(
    int orderId,
    List<String> memberIds,
  ) async {
    try {
      await client
          .schema('communities')
          .from('eesupool_order')
          .update({'receivers': memberIds.toList()}).eq('id', orderId);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<List<OrderProduct>> fetchPoolOrderProducts(int orderId) async {
    final res =
        await client.schema('sales').rpc('get_pool_order_products', params: {
      'ord_id': orderId,
    });
    return (res as List).map((e) => OrderProduct.fromJson(e)).toList();
  }
}
