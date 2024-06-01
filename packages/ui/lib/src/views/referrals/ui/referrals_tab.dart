import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/auth/repository/referrals_repository.dart';
import 'package:data/referrals/data_source/referrals_supabase_impl.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/referrals/models/referral.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/referrals/bloc/referrals_bloc.dart';

// final referralsProvider =
//     FutureProvider.autoDispose<List<Referral>>((ref) async {
//   final repo = ref.read(referralsRepoProvider);
//   final results = await repo.fetchReferrals();
//   return results.fold((l) => throw l, (r) => r);
// });

class ReferralsTab extends StatelessWidget {
  const ReferralsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ReferralsRepository(
        context.read<AuthRepository>(),
        ReferralsSupabaseImpl(
          GetIt.I.get<SupabaseClient>(),
        ),
      ),
      child: BlocProvider(
        create: (context) => ReferralsBloc(context.read<ReferralsRepository>())
          ..add(ReferralsFetched()),
        child: BlocBuilder<ReferralsBloc, ReferralsState>(
          builder: (context, state) {
            if (state is ReferralsLoaded) {
              final referrals = state.referrals;
              if (referrals.isEmpty) {
                return FullScreenError(
                  isError: false,
                  exception: EESUpException(
                    message: 'You have not referred anyone yet.',
                  ),
                );
              }
              return ListView.builder(
                itemCount: referrals.length,
                itemBuilder: (context, index) {
                  final referral = referrals[index];
                  return _ReferralCard(referral: referral);
                },
              );
            } else if (state is ReferralsLoading) {
              return const FullScreenLoadingShimmer();
            } else if (state is ReferralsError) {
              return FullScreenError(exception: state.exception);
            } else {
              return FullScreenError(
                exception: EESUpException(message: ''),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ReferralCard extends StatelessWidget {
  const _ReferralCard({required this.referral});

  final Referral referral;

  @override
  Widget build(BuildContext context) {
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
  }
}
