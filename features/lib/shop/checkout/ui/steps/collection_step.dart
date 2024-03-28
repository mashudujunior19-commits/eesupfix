import 'package:data_sources/eesupreneur/data_source/eesupreneur_supabase_data_soruce.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/shop/checkout/bloc/collection_points_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/partners/eesupreneur_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CollectionStep extends StatelessWidget {
  const CollectionStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EESUpreneurRepository(
        EESUpreneurSupabaseDataSource(GetIt.I.get<SupabaseClient>()),
        context.read<AuthRepository>(),
      ),
      child: BlocProvider(
        create: (context) => CollectionPointsBloc(
            context.read<EESUpreneurRepository>(),
            context.read<EESUpoolRepository>())
          ..add(
            CollectionPointsRequested(address),
          ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              _TabBar(),
              // Expanded(
              //   child: TabBarView(
              //     children: [
              //       _EESUpreneursTab(tabController: tabController),
              //       _EESUpoolOrders(tabController: tabController),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 26,
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.white,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.displayMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: RectangularIndicator(
          bottomLeftRadius: 8,
          bottomRightRadius: 8,
          topLeftRadius: 8,
          topRightRadius: 8,
          color: context.colorScheme.primary,
        ),
        tabs: const [
          Tab(text: 'Kasipreneurs'),
          Tab(text: 'EESUpools'),
        ],
      ),
    );
  }
}
