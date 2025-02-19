// part of 'overview_bloc.dart';

// @immutable
// sealed class OverviewState {}

// final class OverviewLoading extends OverviewState {}

// final class OverviewContentsLoaded extends OverviewState {
//   final List<Category> categories;
//   final List<Product> forYouProducts;
//   final List<Product> popularProducts;
//   final List<Product> essentialProducts;

//   final AdBanner topBanner;
//   final AdBanner bottomBanner;

//   OverviewContentsLoaded({
//     required this.categories,
//     required this.forYouProducts,
//     required this.popularProducts,
//     required this.essentialProducts,
//     required this.topBanner,
//     required this.bottomBanner,
//   });
// }

// final class OverviewError extends OverviewState {
//   final EESUpException exception;

//   OverviewError(this.exception);
// }

part of 'overview_bloc.dart';

@immutable
sealed class OverviewState {}

final class OverviewLoading extends OverviewState {}

final class OverviewContentsLoaded extends OverviewState {
  final List<Category> categories;
  final List<Product> forYouProducts;
  final List<Product> popularProducts;
  final List<Product> essentialProducts;

  final List<HamperBannerDetail> topBanner;
  final List<HamperBannerDetail> bottomBanner;

  OverviewContentsLoaded({
    required this.categories,
    required this.forYouProducts,
    required this.popularProducts,
    required this.essentialProducts,
    required this.topBanner,
    required this.bottomBanner,
  });
}

final class OverviewError extends OverviewState {
  final EESUpException exception;

  OverviewError(this.exception);
}
