import 'dart:async';
import 'dart:io';
import 'package:either_dart/either.dart';
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

  static fromException(Object e, StackTrace? stackTrace) {
    return EESUpException(
        message: 'An unexpected problem occurred. Please try again.',
        debugMessage: e.toString(),
        stackTrace: stackTrace);
  }

  @override
  int get hashCode => debugMessage.hashCode ^ message.hashCode;

  /// Maps AuthException messages to user-friendly error messages
  static String _getAuthErrorMessage(AuthException exception) {
    final errorMessage = exception.message.toLowerCase();

    if (errorMessage.contains('invalid login credentials') ||
        errorMessage.contains('invalid credentials')) {
      return 'Incorrect email/phone or password. Please try again.';
    }
    if (errorMessage.contains('email not confirmed')) {
      return 'Please verify your email before signing in.';
    }
    if (errorMessage.contains('user already registered') ||
        errorMessage.contains('already been registered')) {
      return 'An account with this email already exists.';
    }
    if (errorMessage.contains('phone') && errorMessage.contains('registered')) {
      return 'An account with this phone number already exists.';
    }
    if (errorMessage.contains('invalid otp') ||
        errorMessage.contains('otp expired') ||
        errorMessage.contains('token has expired')) {
      return 'Invalid or expired OTP. Please request a new one.';
    }
    if (errorMessage.contains('password') &&
        (errorMessage.contains('weak') || errorMessage.contains('short'))) {
      return 'Password is too weak. Please use a stronger password.';
    }
    if (errorMessage.contains('rate limit') ||
        errorMessage.contains('too many requests')) {
      return 'Too many attempts. Please wait a moment and try again.';
    }
    if (errorMessage.contains('session') && errorMessage.contains('expired')) {
      return 'Your session has expired. Please sign in again.';
    }
    if (errorMessage.contains('not authorized') ||
        errorMessage.contains('unauthorized')) {
      return 'You are not authorized to perform this action.';
    }

    // Default auth error message
    return 'Authentication failed. Please try again.';
  }

  /// Maps PostgrestException messages to user-friendly error messages
  static String _getPostgrestErrorMessage(PostgrestException exception) {
    final errorMessage = exception.message.toLowerCase();
    final code = exception.code;

    // Handle specific error codes
    if (code == '23505') {
      // Unique violation
      return 'This record already exists.';
    }
    if (code == '23503') {
      // Foreign key violation
      return 'This operation references data that does not exist.';
    }
    if (code == '42501') {
      // Permission denied
      return 'You do not have permission to perform this action.';
    }

    // Handle error messages
    if (errorMessage.contains('duplicate') ||
        errorMessage.contains('already exists')) {
      return 'This record already exists.';
    }
    if (errorMessage.contains('not found')) {
      return 'The requested data could not be found.';
    }
    if (errorMessage.contains('permission') ||
        errorMessage.contains('denied')) {
      return 'You do not have permission to perform this action.';
    }

    // Default database error
    return 'A database error occurred. Please try again.';
  }

  static Either<EESUpException, T> _handleException<T>(Object exception) {
    if (kDebugMode) {
      print('EESUpException:=> ${exception.toString()}');
    }

    if (exception is AuthException) {
      final message = _getAuthErrorMessage(exception);
      return Left(EESUpException(
          message: message, debugMessage: exception.toString()));
    } else if (exception is PostgrestException) {
      final message = _getPostgrestErrorMessage(exception);
      return Left(EESUpException(
          message: message, debugMessage: exception.toString()));
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
