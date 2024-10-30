part of 'hamper_bloc.dart';

@immutable
sealed class HamperEvent {}

class FetchHampers extends HamperEvent {}

class FetchHampersByImageUrl extends HamperEvent {
  final String imageUrl;
  FetchHampersByImageUrl(this.imageUrl);
}

class FetchHamperProducts extends HamperEvent {
  final String hamperId;
  FetchHamperProducts(this.hamperId);
}
