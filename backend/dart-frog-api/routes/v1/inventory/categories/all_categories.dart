import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/inventory/inventory_repository.dart';
import 'package:get_it/get_it.dart';

Future<Response> onRequest(RequestContext context) async {
  final inventoryRepository = GetIt.I.get<InventoryRepository>();
  return await inventoryRepository.fetchCategories();
}
