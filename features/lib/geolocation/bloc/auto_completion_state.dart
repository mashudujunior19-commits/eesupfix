part of 'auto_completion_bloc.dart';

@immutable
sealed class AutoCompletionState {}

final class AutoCompletionInitial extends AutoCompletionState {}

final class AutoCompletionLoading extends AutoCompletionState {}

final class AutoCompletionsLoaded extends AutoCompletionState {
  final List<GooglePlace> suggestions;
  AutoCompletionsLoaded(this.suggestions);
}
