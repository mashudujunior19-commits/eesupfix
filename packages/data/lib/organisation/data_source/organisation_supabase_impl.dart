import 'package:data/organisation/data_source/organisation_data_source.dart';
import 'package:data/organisation/models/organisation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrganisationSupabaseImpl implements OrganisationDataSource {
  final SupabaseClient client;

  OrganisationSupabaseImpl({required this.client});

  @override
  Future<Organisation> createOrganisation(Organisation organisation) async {
    final response = await client
        .schema('services')
        .from('organisation')
        .insert(organisation.toJson())
        .select()
        .single();
    return Organisation.fromJson(response);
  }

  @override
  Future<List<Organisation>> fetchOrganisationsByOwner(String ownerId) async {
    final response = await client
        .schema('services')
        .from('organisation')
        .select()
        .eq('owner_id', ownerId)
        .order('created_at', ascending: false);
    return response.map((e) => Organisation.fromJson(e)).toList();
  }
}
