part of 'issues_cubit.dart';

@immutable
sealed class IssuesState {}

final class IssuesLoading extends IssuesState {}

final class IssuesLoaded extends IssuesState {
  final List<EESUpoolIssue> issues;
  IssuesLoaded(this.issues);
}


final class IssuesError extends IssuesState {
  final EESUpException err;
  IssuesError(this.err);
}