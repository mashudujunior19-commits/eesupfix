import 'dart:typed_data';

import 'package:data/get_involved/data_source/get_involved_data_source.dart';
import 'package:data/get_involved/models/contact_person.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
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
              'email': c.email,
              'phone': c.phone,
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
}
