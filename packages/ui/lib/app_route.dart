import 'package:auto_route/auto_route.dart';
import 'package:ui/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: StartUpRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: SignInRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EditProfileRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: OverviewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ResetPasswordRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: InstapayRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EESUpoolViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: OrderTrackingRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: CartRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: CheckoutRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: AddressBookRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EditAddressRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: OzowRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: YocoPaymentRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: InstapayConfirmDetailsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: RegisterRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: BrowseShopRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: CategoryRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: WalletViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: TransferRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: PayoutRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: SettingsRoutes.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: OrderTrackingRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: BasketViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: BasketsListRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EESUpoolOrderViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: PartnerRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: PartnerAppRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: SurveyRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ResponseRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: OrderReceiverRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: KasipreneurRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ReviewProductsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EESUpoolSearchRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ProductViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: CreateEESUpoolRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ResponseRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: EditApplicationRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: TermsOfServiceRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: ProductRequestRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: IssueViewRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
        ),
      ];
}
