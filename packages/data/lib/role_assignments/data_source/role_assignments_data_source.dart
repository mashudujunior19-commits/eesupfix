import 'dart:typed_data';

import 'package:data/role_assignments/models/checklist_item.dart';
import 'package:data/role_assignments/models/order_receipt.dart';
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

  Future<ReceiptState> fetchReceiptState(int eesupoolOrderId) async {
    final res = await _client.schema('communities').rpc(
      'get_order_receipt_state',
      params: {'_eesupool_order_id': eesupoolOrderId},
    );
    final rows = res as List;
    if (rows.isEmpty) {
      return const ReceiptState(
        isReceiver: false,
        isAdmin: false,
        isDispatched: false,
        confirmedAt: null,
      );
    }
    return ReceiptState.fromJson(Map<String, dynamic>.from(rows.first as Map));
  }

  Future<List<ReceiptItem>> fetchReceipt(int eesupoolOrderId) async {
    final res = await _client.schema('communities').rpc(
      'get_order_receipt',
      params: {'_eesupool_order_id': eesupoolOrderId},
    );
    return (res as List)
        .map((e) => ReceiptItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> saveReceiptItem({
    required int eesupoolOrderId,
    required ReceiptItem item,
  }) async {
    await _client.schema('communities').rpc(
      'save_order_receipt_item',
      params: {
        '_eesupool_order_id': eesupoolOrderId,
        '_product_id': item.productId,
        '_received_qty': item.receivedQty,
        '_is_faulty': item.isFaulty,
        '_comment': item.faultComment,
        '_photo_url': item.faultPhotoUrl,
      },
    );
  }

  Future<void> confirmReceipt(int eesupoolOrderId) async {
    await _client.schema('communities').rpc(
      'confirm_order_receipt',
      params: {'_eesupool_order_id': eesupoolOrderId},
    );
  }

  Future<DeliveryInfo> fetchDeliveryInfo(int eesupoolOrderId) async {
    final res = await _client.schema('communities').rpc(
      'get_order_delivery_info',
      params: {'_eesupool_order_id': eesupoolOrderId},
    );
    final rows = res as List;
    if (rows.isEmpty) return const DeliveryInfo(expectedDate: null, pin: null);
    return DeliveryInfo.fromJson(Map<String, dynamic>.from(rows.first as Map));
  }

  /// Uploads a photo of a faulty item and returns its public URL.
  Future<String> uploadFaultPhoto(String path, Uint8List bytes) async {
    final bucket = _client.storage.from('order_tickets');
    await bucket.uploadBinary(path, bytes);
    return bucket.getPublicUrl(path);
  }
}
