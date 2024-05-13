part of 'kasipreneur_bloc.dart';

@immutable
sealed class KasipreneurState {}

final class KasipreneurInitial extends KasipreneurState {}

final class KasipreneursLoaded extends KasipreneurState {
  final List<EESUpreneur> kasipreneurs;
  KasipreneursLoaded(this.kasipreneurs);
}

final class KasipreneursError extends KasipreneurState {
  final EESUpException exception;
  KasipreneursError(this.exception);
}
