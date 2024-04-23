import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_status.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_transaction.dart';
import 'package:eesup_dart_frog/src/payments/data/providers/payment_provider.dart';

class OzowRepository {
  OzowRepository(this.paymentGatewayProvider);
  final PaymentGatewayProvider paymentGatewayProvider;

  Future<Response> confirmOzowPayment({
    required int? transRef,
    required double? amount,
    required String? hash,
    required bool isTest,
    required String? type,
  }) async {
    ///check if any of the required parameters is null
    if (transRef == null || amount == null || hash == null || type == null) {
      return Response.json(statusCode: HttpStatus.badRequest, body: {
        'status': 'error',
        'message': 'One or more required parameters are missing',
      });
    }

    ///fetch trasnaction
    final transaction = await paymentGatewayProvider.fetchOzowTransaction(
      reference: transRef.toString(),
      isTest: isTest,
    );
    if (transaction == null) {
      return Response.json(statusCode: HttpStatus.badRequest, body: {
        'status': 'error',
        'message': 'Transaction not found {Unknown ozow transaction}',
      });
    }
    return _updateOzowTransaction(transRef, transaction, type);
  }

  Future<Response> _updateOzowTransaction(
    int ref,
    OzowTransaction transaction,
    String type,
  ) async {
    switch (transaction.status) {
      case OzowStatus.Complete:
        final success = await paymentGatewayProvider.confirmOnlinePayment(
          reference: ref,
          isConfirmed: true,
        );
        if (!success) {
          return Response.json(statusCode: HttpStatus.badRequest, body: {
            'status': OzowStatus.Error.name,
            'message': 'Failed to confirm transaction',
          });
        } else {
          return Response.json(body: {
            'status': OzowStatus.Complete.name,
            'message': 'Transaction confirmed successfully',
          });
        }
      case OzowStatus.Cancelled:
        final success = await paymentGatewayProvider.confirmOnlinePayment(
          reference: ref,
          isConfirmed: false,
        );

        if (!success) {
          return Response.json(statusCode: HttpStatus.badRequest, body: {
            'status': OzowStatus.Error.name,
            'message': 'Failed to confirm transaction',
          });
        } else {
          return Response.json(body: {
            'status': OzowStatus.Cancelled.name,
            'message': 'Transaction cancelled',
          });
        }
      case OzowStatus.Abandoned:
        paymentGatewayProvider.confirmOnlinePayment(
            reference: ref, isConfirmed: false);
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': OzowStatus.Abandoned.name,
          'message': 'Transaction abandoned',
        });
      case OzowStatus.PendingInvestigation:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': OzowStatus.PendingInvestigation.name,
          'message': 'Transaction pending investigation',
        });
      case OzowStatus.Pending:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': OzowStatus.Pending.name,
          'message': 'Transaction pending',
        });
      case OzowStatus.Error:
        paymentGatewayProvider.confirmOnlinePayment(
            reference: ref, isConfirmed: false);
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': OzowStatus.Error.name,
          'message': 'Transaction error',
        });
      case null:
        return Response.json(statusCode: HttpStatus.badRequest, body: {
          'status': OzowStatus.Error.name,
          'message': 'Transaction status not found',
        });
    }
  }
}
