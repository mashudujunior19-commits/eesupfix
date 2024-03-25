part of 'eesupool_type_bloc.dart';

@immutable
sealed class EESUpoolTypeViewState {}

final class EESUpoolTypeViewInitial extends EESUpoolTypeViewState {}

final class EESUpoolTypeViewLoading extends EESUpoolTypeViewState {}

final class EESUpoolsTypeViewLoaded extends EESUpoolTypeViewState {
  final List<EESUpool> eesupools;
  final int kasiPoolsCount;
  EESUpoolsTypeViewLoaded(this.eesupools, this.kasiPoolsCount);
}

final class EESUpoolTypeViewError extends EESUpoolTypeViewState {
  final EESUpException exception;
  EESUpoolTypeViewError(this.exception);
}
