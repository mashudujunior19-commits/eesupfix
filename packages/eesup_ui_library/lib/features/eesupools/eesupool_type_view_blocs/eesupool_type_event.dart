part of 'eesupool_type_bloc.dart';

@immutable
sealed class EESUpoolTypeEvent {}

final class EESUpoolsTypeViewFetched extends EESUpoolTypeEvent {
  final EESUpoolType type;
  EESUpoolsTypeViewFetched(this.type);
}
