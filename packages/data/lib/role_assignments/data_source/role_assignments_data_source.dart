import 'package:data/role_assignments/models/checklist_item.dart';
import 'package:data/role_assignments/models/role_assigned_order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoleAssignmentsDataSource {
  final SupabaseClient _client;

  RoleAssignmentsDataSource(this._client);

  Future<List<RoleAssignedOrder>> fetchMyRoleAssignedOrders() async {
    final res = await _client
        .schema('communities')
        .rpc('get_my_role_assigned_orders');
    return (res as List)
        .map((e) => RoleAssignedOrder.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChecklistItem>> fetchChecklist(
    int eesupoolOrderId,
    int? orderId,
  ) async {
    final res = await _client.schema('communities').rpc(
      'get_role_checklist',
      params: {'_eesupool_order_id': eesupoolOrderId, '_order_id': orderId},
    );
    return (res as List)
        .map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> setChecklistItem({
    required int eesupoolOrderId,
    required int? orderId,
    required int productId,
    required bool checked,
  }) async {
    await _client.schema('communities').rpc(
      'set_role_checklist_item',
      params: {
        '_eesupool_order_id': eesupoolOrderId,
        '_order_id': orderId,
        '_product_id': productId,
        '_checked': checked,
      },
    );
  }
}
