import 'dart:io';

import 'package:data/get_involved/data_source/get_involved_data_source.dart';
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
  Future<String?> uploadDocumentFile(String path, File file) async {
    try {
      await client.storage.from(_bucket).upload(
            path,
            file,
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
