import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data_sources/referrals/models/referral.dart';

// final referralsProvider =
//     FutureProvider.autoDispose<List<Referral>>((ref) async {
//   final repo = ref.read(referralsRepoProvider);
//   final results = await repo.fetchReferrals();
//   return results.fold((l) => throw l, (r) => r);
// });

@RoutePage()
class ReferralsView extends StatelessWidget {
  const ReferralsView({super.key});

  @override
  Widget build(BuildContext context) {
    final referrals = <Referral>[];
    return ListView.builder(
      itemCount: referrals.length,
      itemBuilder: (context, index) {
        final referral = referrals[index];
        return Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade50.withOpacity(.7),
              child: const Icon(
                IconlyLight.profile,
                color: Colors.green,
              ),
            ),
            title: Text(referral.refereedFullName),
            subtitle: Text(
              referral.isCompleted ? 'Completed' : 'Not Completed',
              style: TextStyle(
                color: !referral.isCompleted ? Colors.redAccent : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        );
      },
    );
  }
}
