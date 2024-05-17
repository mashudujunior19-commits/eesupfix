part of 'addresses_bloc.dart';

@immutable
sealed class AddressesEvent {}

final class AddressesFetched extends AddressesEvent {}

final class AddressDeleted extends AddressesEvent {
  final int id;
  AddressDeleted(this.id);
}
