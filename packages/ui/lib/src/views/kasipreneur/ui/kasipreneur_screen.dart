import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/eesupreneur/data_source/eesupreneur_supabase_data_soruce.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/partners/repository/eesupreneur_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/kasipreneur/bloc/kasipreneur_view_bloc.dart';
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_orders_tab.dart';
import 'package:ui/src/views/kasipreneur/ui/kasipreneur_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

@RoutePage()
class KasipreneurScreen extends StatelessWidget {
  const KasipreneurScreen({super.key, required this.eesupreneur});
  final EESUpreneur eesupreneur;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EESUpreneurRepository(
        EESUpreneurSupabaseDataSource(GetIt.I.get<SupabaseClient>()),
        context.read<AuthRepository>(),
      ),
      child: BlocProvider(
        create: (context) => KasipreneurViewBloc(
          context.read<EESUpreneurRepository>(),
        )..add(KasipreneurViewInitialized(eesupreneur)),
        child: SizedBox(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: Text(eesupreneur.name),
            ),
            body: Container(
              decoration: context.bgImage,
              height: context.height,
              width: context.width,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width,
                      padding: const EdgeInsets.only(bottom: 10, left: 20),
                      height: 40,
                      color: Colors.white,
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorPadding: const EdgeInsets.all(0),
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelColor: Colors.white,
                        labelStyle: context.textTheme.labelMedium?.copyWith(
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
                          Tab(text: 'ORDERS'),
                          Tab(text: 'SETTINGS'),
                        ],
                      ),
                    ),
                    BlocBuilder<KasipreneurViewBloc, KasipreneurViewState>(
                      builder: (context, state) {
                        if (state is KasipreneurViewCurrentState) {
                          return Expanded(
                            child: TabBarView(
                              children: [
                                KasipreneurOrdersTab(
                                  eesupreneur: state.eesupreneur,
                                ),
                                KasipreneurSettingsTab(
                                  eesupreneur: state.eesupreneur,
                                ),
                              ],
                            ),
                          );
                        } else if (state is KasipreneurViewLoading) {
                          return const FullScreenLoadingShimmer();
                        } else if (state is KasipreneurViewError) {
                          return FullScreenError(exception: state.error);
                        } else {
                          return FullScreenError(
                            exception: EESUpException(message: ''),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
