import 'package:either_dart/either.dart';
import 'package:data/utils/eesup_exception.dart';

import '../models/hamper_offer.dart';
import 'shopping_repository.dart';

extension HamperRepository on ShoppingRepository {
  /// Every hamper the signed-in user may see, with what is inside, in one call.
  Future<Either<EESUpException, List<HamperOffer>>> fetchHamperOffers() async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      return shoppingDataSrc.fetchHamperOffers();
    });
    return result.fold((ex) => Left(ex), (offers) => Right(offers));
  }

  /// One hamper, or null when it does not exist, has ended or is not meant for
  /// this user.
  Future<Either<EESUpException, HamperOffer?>> fetchHamperOffer(
      String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final offers =
          await shoppingDataSrc.fetchHamperOffers(hamperId: hamperId);
      return offers.isEmpty ? null : offers.first;
    });
    return result.fold((ex) => Left(ex), (offer) => Right(offer));
  }
}
