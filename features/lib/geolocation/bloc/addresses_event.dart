part of 'addresses_bloc.dart';

@immutable
sealed class AddressesEvent {}

final class AddressesFetched extends AddressesEvent {}
