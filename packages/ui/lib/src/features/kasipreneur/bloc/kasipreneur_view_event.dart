part of 'kasipreneur_view_bloc.dart';

@immutable
sealed class KasipreneurViewEvent {}

final class KasipreneurViewInitialized extends KasipreneurViewEvent {
  final EESUpreneur eesupreneur;
  KasipreneurViewInitialized(this.eesupreneur);
}

final class KasipreneurViewUpdated extends KasipreneurViewEvent {
  final EESUpreneur eesupreneur;
  KasipreneurViewUpdated(this.eesupreneur);
}
