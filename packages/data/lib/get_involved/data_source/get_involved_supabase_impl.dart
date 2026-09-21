import 'package:data/get_involved/data_source/get_involved_data_source.dart';
import 'package:data/get_involved/models/get_involved_application.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetInvolvedSupabaseImpl implements GetInvolvedDataSource {
  final SupabaseClient client;

  GetInvolvedSupabaseImpl({required this.client});

  @override
  Future<GetInvolvedApplication> createApplication(
    GetInvolvedApplication application,
  ) async {
    final response = await client
        .schema('services')
        .from('get_involved_application')
        .insert(application.toJson())
        .select()
        .single();
    return GetInvolvedApplication.fromJson(response);
  }

  @override
  Future<List<GetInvolvedApplication>> fetchApplicationsByUser(
    String userId,
  ) async {
    final response = await client
        .schema('services')
        .from('get_involved_application')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response.map((e) => GetInvolvedApplication.fromJson(e)).toList();
  }
}
