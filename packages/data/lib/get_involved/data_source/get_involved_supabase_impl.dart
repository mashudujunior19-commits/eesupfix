import 'dart:typed_data';

import 'package:data/get_involved/data_source/get_involved_data_source.dart';
import 'package:data/get_involved/models/contact_person.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/profile_switch_state.dart';
import 'package:data/get_involved/models/submission_document.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetInvolvedSupabaseImpl implements GetInvolvedDataSource {
  static const _bucket = 'get_involved_documents';

  final SupabaseClient client;

  GetInvolvedSupabaseImpl({required this.client});

  @override
  Future<GetInvolvedSubmission> createSubmission(
    GetInvolvedSubmission submission,
  ) async {
    final response = await client
        .schema('services')
        .from('get_involved_submissions')
        .insert(submission.toJson())
        .select()
        .single();
    return GetInvolvedSubmission.fromJson(response);
  }

  @override
  Future<GetInvolvedSubmission> updateSubmission(
    GetInvolvedSubmission submission,
  ) async {
    final response = await client
        .schema('services')
        .from('get_involved_submissions')
        .update(submission.toJson())
        .eq('id', submission.id!)
        .select()
        .single();
    return GetInvolvedSubmission.fromJson(response);
  }

  @override
  Future<String?> uploadDocumentFile(String path, Uint8List bytes) async {
    try {
      await client.storage.from(_bucket).uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      return path;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<SubmissionDocument> attachDocument(SubmissionDocument document) async {
    final response = await client
        .schema('services')
        .from('submission_documents')
        .insert(document.toJson())
        .select()
        .single();
    return SubmissionDocument.fromJson(response);
  }

  @override
  Future<List<ContactPerson>> attachContactPersons(
    String submissionId,
    List<ContactPerson> contactPersons,
  ) async {
    if (contactPersons.isEmpty) return [];
    final rows = contactPersons
        .map((c) => {
              'submission_id': submissionId,
              if (c.name != null) 'name': c.name,
              'email': c.email,
              'phone': c.phone,
              if (c.role != null) 'role': c.role.toString(),
            })
        .toList();
    final response = await client
        .schema('services')
        .from('submission_contacts')
        .insert(rows)
        .select();
    return response.map((e) => ContactPerson.fromJson(e)).toList();
  }

  @override
  Future<List<GetInvolvedSubmission>> fetchSubmissionsByUser(
    String userId,
  ) async {
    final response = await client
        .schema('services')
        .from('get_involved_submissions')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response.map((e) => GetInvolvedSubmission.fromJson(e)).toList();
  }

  @override
  Future<({bool ok, String? message})> becomeKasipromoter() async {
    final res = await client.rpc('become_kasipromoter');
    return _okMessage(res);
  }

  @override
  Future<({bool ok, String? message})> kasipromoterEligibility() async {
    final res = await client.rpc('get_kasipromoter_eligibility');
    final rows = res as List;
    if (rows.isEmpty) return (ok: false, message: null);
    final row = Map<String, dynamic>.from(rows.first as Map);
    return (
      ok: (row['eligible'] as bool?) ?? false,
      message: row['message'] as String?,
    );
  }

  ({bool ok, String? message}) _okMessage(dynamic res) {
    final rows = res as List;
    if (rows.isEmpty) return (ok: false, message: null);
    final row = Map<String, dynamic>.from(rows.first as Map);
    return (
      ok: (row['ok'] as bool?) ?? false,
      message: row['message'] as String?,
    );
  }

  @override
  Future<ProfileSwitchState> profileSwitchState() async {
    final rows = await client.rpc('get_profile_switch_state') as List;
    if (rows.isEmpty) return ProfileSwitchState.unavailable;
    final row = Map<String, dynamic>.from(rows.first as Map);
    return ProfileSwitchState(
      available: (row['available'] as bool?) ?? false,
      businessActive: row['active_profile'] == 'business',
      businessName: row['business_name'] as String?,
    );
  }

  @override
  Future<ProfileSwitchState> switchProfile({required bool toBusiness}) async {
    await client.rpc('switch_profile', params: {
      '_to': toBusiness ? 'business' : 'individual',
    });
    // read back what is now active (and the organisation's name)
    return profileSwitchState();
  }
}
