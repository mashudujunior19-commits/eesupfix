import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/payments/data/data_source/payment_api.dart';
import 'package:eesup_dart_frog/src/payments/data/models/instapay_status.dart';

class InstapayServices {
  final PaymentApi api;

  InstapayServices(this.api);

  Future<Response> confirmInstaPayment(Map<String, dynamic> json) async {
    //calculate checksum
    final payeeUuid = json['payeeUuid'].toString();
    final payeeAccountUuid = json['payeeAccountUuid'].toString();
    final payeeRefInfo = json['payeeRefInfo'].toString();
    final amount = double.tryParse(json['requestAmount'].toString()) ?? 0.00;
    final amountInCents = (amount * 100).toInt().toString();
    final currency = json['requestCurrency'].toString();
    const secret = '33SuP@2024';

    List<String> checksumString = [
      payeeUuid,
      payeeAccountUuid,
      payeeRefInfo,
      amountInCents.replaceAll(RegExp(r'\D'), ''),
      currency,
      secret
    ];

    final str = checksumString.join('_');

    String checksum = md5.convert(utf8.encode(str)).toString();

    if (checksum != json['checksum']) {
      return Response.json(statusCode: HttpStatus.badRequest, body: {
        'status': 'error',
        'message': 'Invalid checksum',
      });
    }

    // return Response.json(statusCode: HttpStatus.ok, body: {
    //   'status': 'success',
    //   'message': 'Checksum valid',
    // });
    final reference = int.tryParse(json['payeeCategory1']);

    if (reference == null) {
      return Response.json(statusCode: HttpStatus.badRequest, body: {
        'status': 'error',
        'message': 'Invalid reference id',
      });
    }

    final type = json['payeeCategory2'];

    if (type == null) {
      return Response.json(statusCode: HttpStatus.badRequest, body: {
        'status': 'error',
        'message': 'Invalid type',
      });
    }

    //confirm payment
    final response = await _updatePayment(
      reference,
      type,
      InstapayStatus.fromString(json['requestStatus']),
    );

    return response;
  }

  Future<Response> _updatePayment(
      int reference, String type, InstapayStatus status) async {
    switch (status) {
      case InstapayStatus.completed:
        final success = await api.confirmInstapayEft(
          orderId: reference,
          status: InstapayStatus.completed,
          type: type,
        );
        if (success) {
          return Response.json(statusCode: HttpStatus.ok, body: {
            'status': 'success',
            'message': 'Transaction confirmed',
          });
        } else {
          return Response.json(statusCode: HttpStatus.badRequest, body: {
            'status': 'error',
            'message': 'Failed to confirm transaction',
          });
        }
      case InstapayStatus.expired:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': 'error',
          'message': 'Transaction expired',
        });
      case InstapayStatus.pending:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': 'error',
          'message': 'Transaction pending',
        });
      case InstapayStatus.concelled:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': 'error',
          'message': 'Transaction cancelled',
        });
    }
  }
}
