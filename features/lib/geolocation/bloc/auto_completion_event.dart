part of 'auto_completion_bloc.dart';

@immutable
sealed class AutoCompletionEvent {}

final class AutoCompletionRequested extends AutoCompletionEvent {
  final String key;
  final String input;
  AutoCompletionRequested(this.key,this.input);
}
