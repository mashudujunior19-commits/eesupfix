part of 'overview_bloc.dart';

@immutable
sealed class OverviewEvent {}

final class OvervewLoaded extends OverviewEvent {
  final UserRole role;
  final int limit;

  OvervewLoaded({
    required this.role,
    required this.limit,
  });
}
