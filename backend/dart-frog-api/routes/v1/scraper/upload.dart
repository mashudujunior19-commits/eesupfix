import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/scrapers/scraper_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    // ignore: avoid_print
    print("Received a post");
    //extract the request from the context
    final request = context.request;
    //check if the request is a post request
    if (request.method != HttpMethod.post) {
      return Response.json(
        body: {'messsage': 'Unsupported method: ${request.method.value}'},
        statusCode: 405,
      );
    }

    final body = await request.json();
    final repo = ScraperRepository();
    final results = await repo.uploadProduct(body as Map<String, dynamic>);
    return results;
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {"error": "Internal server error"},
    );
  }
}
