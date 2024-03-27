part of 'addresses_bloc.dart';

@immutable
sealed class AddressesState {}

final class AddressesLoading extends AddressesState {}

final class AddressesError extends AddressesState {
  final EESUpException ex;
  AddressesError(this.ex);
}

final class AddressesLoaded extends AddressesState {
  final List<Address> addresses;
  AddressesLoaded(this.addresses);
}
