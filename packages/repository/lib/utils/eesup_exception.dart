import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A custom exception class that encapsulates error details for Flutter apps.
///
/// This class is designed to handle and represent different types of exceptions
/// with a user-friendly message and an optional debug message for developers.
class EESUpException implements Exception {
  /// A message intended to be safe and understandable for end users.
  final String message;

  /// An optional message providing more technical details, useful for debugging.
  final String? debugMessage;

  final StackTrace? stackTrace;

  /// Constructs a [EESUpException] instance with required [message] and optional [debugMessage].
  EESUpException({
    required this.message,
    this.debugMessage,
    this.stackTrace,
  });

  @override
  String toString() =>
      'EESUpException(debugMessage: $debugMessage, message: $message , stackTrace: $stackTrace)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EESUpException &&
        other.debugMessage == debugMessage &&
        other.message == message;
  }

  static fromException(Object e,StackTrace? stackTrace) {
    return EESUpException(
      message:'An unexpected problem occurred. Please try again.' ,
      debugMessage: e.toString(),
      stackTrace: stackTrace
    );
  }

  @override
  int get hashCode => debugMessage.hashCode ^ message.hashCode;

  static Either<EESUpException, T> _handleException<T>(Object exception) {
    if (kDebugMode) {
      print('EESUpException:=> ${exception.toString()}');
    }

    if (exception is AuthException) {
      return Left(EESUpException(
          message: 'Invalid credentials. Please try again.',
          debugMessage: exception.toString()));
    } else if (exception is HandshakeException) {
      return Left(EESUpException(
          message: 'This is taking longer than usual. Check your connection.',
          debugMessage: exception.toString()));
    } else if (exception is ArgumentError) {
      return Left(EESUpException(
          message: 'An unexpected problem occurred. Please try again.',
          debugMessage: exception.toString()));
    } else if (exception is TimeoutException) {
      return Left(EESUpException(
          message: 'This is taking longer than usual. Check your connection.',
          debugMessage: exception.toString()));
    } else if (exception is SocketException) {
      return Left(EESUpException(
          message: 'Please check your internet connection.',
          debugMessage: exception.toString()));
    } else if (exception is HttpException) {
      return Left(EESUpException(
          message: 'Something went wrong. Please try again later.',
          debugMessage: exception.toString()));
    } else if (exception is IOException) {
      return Left(EESUpException(
          message: 'A problem occurred. Please try again.',
          debugMessage: exception.toString()));
    } else if (exception is FormatException) {
      return Left(EESUpException(
          message: 'The information received is in an unexpected format.',
          debugMessage: exception.toString()));
    } else {
      return Left(EESUpException(
          message: 'An unexpected problem occurred. Please try again.',
          debugMessage: exception.toString()));
    }
  }

  /// Executes the provided [action] and handles known exceptions.
  ///
  /// This static method takes a future-returning function [action] and wraps it in
  /// try-catch blocks to handle specific known exceptions, returning either a [EESUpException]
  /// or a successful result of type [T].
  ///
  /// Returns an [Either] type containing either a [EESUpException] or a successful result [T].
  static Either<EESUpException, T> guardValue<T>(
      {required T Function() action}) {
    try {
      return Right(action());
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  /// Executes the provided Future [action] and handles known exceptions.
  ///
  /// This static method takes a future-returning function [action] and wraps it in
  /// try-catch blocks to handle specific known exceptions, returning either a [EESUpException]
  /// or a successful result of type [T].
  ///
  /// Returns an [Either] type containing either a [EESUpException] or a successful result [T].
  static Future<Either<EESUpException, T>> guardFuture<T>(
      {required Future<T> Function() action}) async {
    try {
      return Right(await action());
    } catch (e) {
      return _handleException<T>(e);
    }
  }

  /// Executes the provided Stream [action] and handles known exceptions.
  ///
  /// This static method takes a future-returning function [action] and wraps it in
  /// try-catch blocks to handle specific known exceptions, returning either a [EESUpException]
  /// or a successful result of type [T].
  ///
  /// Returns an [Either] type containing either a [EESUpException] or a successful result [T].
  static Stream<Either<EESUpException, T>> guardStream<T>(
      {required Stream<T> Function() action}) async* {
    try {
      yield* action().map((event) => Right(event));
    } catch (e) {
      yield _handleException<T>(e);
    }
  }
}

/// A subclass of [EESUpException] specifically for authentication-related errors.
class EESUpAuthException extends EESUpException {
  EESUpAuthException({
    required super.message,
    super.debugMessage,
    super.stackTrace,
  });
}
