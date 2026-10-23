import 'dart:math';
import 'dart:typed_data';

import 'package:data/order_confirmation/models/order_confirmation.dart';
import 'package:data/order_confirmation/repository/order_confirmation_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the member has entered for one line.
class LineEntry {
  const LineEntry({
    required this.line,
    required this.receivedQty,
    this.remedy,
    this.backorderWhen,
    this.photoBytes,
    this.photoExt,
  });

  final ConfirmationLine line;
  final int receivedQty;
  final ConfirmationRemedy? remedy;
  final BackorderWhen? backorderWhen;
  final Uint8List? photoBytes;
  final String? photoExt;

  int get shortBy => line.orderedQty - receivedQty;
  bool get isShort => receivedQty < line.orderedQty;

  /// Null when this line is fine, otherwise a friendly message.
  String? get problem {
    if (receivedQty < 0 || receivedQty > line.orderedQty) {
      return 'Enter a quantity between 0 and ${line.orderedQty}.';
    }
    if (isShort && remedy == null) {
      return 'Choose what you would like us to do about ${line.name}.';
    }
    if (isShort &&
        remedy == ConfirmationRemedy.backorder &&
        backorderWhen == null) {
      return 'Choose when you would like the backorder for ${line.name}.';
    }
    return null;
  }

  LineEntry copyWith({
    int? receivedQty,
    ConfirmationRemedy? remedy,
    BackorderWhen? backorderWhen,
    bool clearRemedy = false,
    bool clearBackorderWhen = false,
    Uint8List? photoBytes,
    String? photoExt,
    bool clearPhoto = false,
  }) {
    return LineEntry(
      line: line,
      receivedQty: receivedQty ?? this.receivedQty,
      remedy: clearRemedy ? null : (remedy ?? this.remedy),
      backorderWhen:
          clearBackorderWhen ? null : (backorderWhen ?? this.backorderWhen),
      photoBytes: clearPhoto ? null : (photoBytes ?? this.photoBytes),
      photoExt: clearPhoto ? null : (photoExt ?? this.photoExt),
    );
  }
}

sealed class ConfirmOrderState {}

final class ConfirmOrderLoading extends ConfirmOrderState {}

final class ConfirmOrderError extends ConfirmOrderState {
  final EESUpException exception;
  ConfirmOrderError(this.exception);
}

/// The order can't be confirmed (or already was): show [confirmation.reason]
/// and, when confirmed, what was received.
final class ConfirmOrderReadOnly extends ConfirmOrderState {
  final OrderConfirmation confirmation;
  ConfirmOrderReadOnly(this.confirmation);
}

final class ConfirmOrderEditing extends ConfirmOrderState {
  final OrderConfirmation confirmation;
  final List<LineEntry> entries;
  final bool submitting;

  /// A one-off error message to show (snackbar), e.g. the save failed.
  final String? message;

  ConfirmOrderEditing(
    this.confirmation,
    this.entries, {
    this.submitting = false,
    this.message,
  });

  bool get isValid => entries.every((e) => e.problem == null);

  String? get firstProblem {
    for (final e in entries) {
      if (e.problem != null) return e.problem;
    }
    return null;
  }

  int get orderedTotal => entries.fold(0, (s, e) => s + e.line.orderedQty);
  int get receivedTotal => entries.fold(0, (s, e) => s + e.receivedQty);
  int get refundCount => entries
      .where((e) => e.isShort && e.remedy == ConfirmationRemedy.refund)
      .fold(0, (s, e) => s + e.shortBy);
  int get backorderCount => entries
      .where((e) => e.isShort && e.remedy == ConfirmationRemedy.backorder)
      .fold(0, (s, e) => s + e.shortBy);
}

final class ConfirmOrderDone extends ConfirmOrderState {
  final ConfirmResult result;
  final bool alreadyConfirmed;

  /// True when a photo could not be uploaded and was left out.
  final bool photoSkipped;
  ConfirmOrderDone(
    this.result, {
    required this.alreadyConfirmed,
    this.photoSkipped = false,
  });
}

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit(this._repository, this.orderId, {String? idempotencyKey})
      : idempotencyKey = idempotencyKey ?? generateIdempotencyKey(),
        super(ConfirmOrderLoading());

  final OrderConfirmationRepository _repository;
  final int orderId;

  /// One key per screen session, so a double tap or retry is safe.
  final String idempotencyKey;

  static String generateIdempotencyKey() {
    final rnd = Random.secure();
    final b = List<int>.generate(16, (_) => rnd.nextInt(256));
    b[6] = (b[6] & 0x0f) | 0x40;
    b[8] = (b[8] & 0x3f) | 0x80;
    String h(int from, int to) => b
        .sublist(from, to)
        .map((e) => e.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${h(0, 4)}-${h(4, 6)}-${h(6, 8)}-${h(8, 10)}-${h(10, 16)}';
  }

  Future<void> load() async {
    emit(ConfirmOrderLoading());
    final result = await _repository.getConfirmation(orderId);
    result.fold(
      (l) => emit(ConfirmOrderError(l)),
      (c) {
        if (!c.canConfirm || c.lines.isEmpty) {
          emit(ConfirmOrderReadOnly(c));
        } else {
          emit(ConfirmOrderEditing(c, [
            for (final l in c.lines)
              LineEntry(line: l, receivedQty: l.orderedQty),
          ]));
        }
      },
    );
  }

  void _change(int productId, LineEntry Function(LineEntry) change) {
    final s = state;
    if (s is! ConfirmOrderEditing || s.submitting) return;
    emit(ConfirmOrderEditing(s.confirmation, [
      for (final e in s.entries)
        e.line.productId == productId ? change(e) : e,
    ]));
  }

  void setReceived(int productId, int qty) {
    _change(productId, (e) {
      final q = qty.clamp(0, e.line.orderedQty);
      // Back to the full quantity: forget the remedy and photo.
      if (q >= e.line.orderedQty) {
        return e.copyWith(
          receivedQty: q,
          clearRemedy: true,
          clearBackorderWhen: true,
          clearPhoto: true,
        );
      }
      return e.copyWith(receivedQty: q);
    });
  }

  void setRemedy(int productId, ConfirmationRemedy remedy) {
    _change(
      productId,
      (e) => e.copyWith(
        remedy: remedy,
        clearBackorderWhen: remedy != ConfirmationRemedy.backorder,
      ),
    );
  }

  void setBackorderWhen(int productId, BackorderWhen when) {
    _change(productId, (e) => e.copyWith(backorderWhen: when));
  }

  void setPhoto(int productId, Uint8List bytes, String ext) {
    _change(productId, (e) => e.copyWith(photoBytes: bytes, photoExt: ext));
  }

  void clearPhoto(int productId) {
    _change(productId, (e) => e.copyWith(clearPhoto: true));
  }

  Future<void> submit() async {
    final s = state;
    if (s is! ConfirmOrderEditing || s.submitting || !s.isValid) return;
    emit(ConfirmOrderEditing(s.confirmation, s.entries, submitting: true));

    // A failed photo upload never blocks the confirmation.
    var photoSkipped = false;
    final inputs = <ConfirmationLineInput>[];
    for (final e in s.entries) {
      String? url;
      if (e.isShort && e.photoBytes != null) {
        url = await _repository.uploadPhoto(
          orderId: orderId,
          bytes: e.photoBytes!,
          extension: e.photoExt ?? 'jpg',
        );
        if (url == null) photoSkipped = true;
      }
      inputs.add(ConfirmationLineInput(
        productId: e.line.productId,
        receivedQty: e.receivedQty,
        remedy: e.isShort ? e.remedy : null,
        backorderWhen: e.isShort && e.remedy == ConfirmationRemedy.backorder
            ? e.backorderWhen
            : null,
        photoUrl: url,
      ));
    }

    final result = await _repository.confirm(
      orderId: orderId,
      lines: inputs,
      idempotencyKey: idempotencyKey,
    );
    result.fold(
      (l) => emit(ConfirmOrderEditing(s.confirmation, s.entries,
          message: l.message)),
      (r) {
        if (r.ok || r.alreadyConfirmed) {
          emit(ConfirmOrderDone(
            r,
            alreadyConfirmed: r.alreadyConfirmed,
            photoSkipped: photoSkipped,
          ));
        } else {
          emit(ConfirmOrderEditing(
            s.confirmation,
            s.entries,
            message: 'We could not confirm your order. Please try again.',
          ));
        }
      },
    );
  }
}
