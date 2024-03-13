import 'package:eesup_data_source/eesupools/data_source/eesupool_supabase_impl.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_type.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/eesupools/eesupool_repo.dart';
import 'package:eesup_ui_library/core/errors/large_error_widget.dart';
import 'package:eesup_ui_library/core/extensions/context_theme_ext.dart';
import 'package:eesup_ui_library/core/extensions/sizedbox_ext.dart';
import 'package:eesup_ui_library/core/extensions/slide_in_animation_ext.dart';
import 'package:eesup_ui_library/core/widgets/large_loading_shimmer.dart';
import 'package:eesup_ui_library/features/eesupools/eesupool_type_view_blocs/eesupool_type_bloc.dart';
import 'package:eesup_ui_library/features/eesupools/widgets/eesupool_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EESUpoolsTypeView extends StatelessWidget {
  const EESUpoolsTypeView({
    super.key,
    required this.type,
    this.showTopActions = true,
  });
  final EESUpoolType type;
  final bool showTopActions;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EESUpoolRepository(
        authRepository: context.read<AuthRepository>(),
        dataSource: EESUpoolSupabaseImp(
          client: GetIt.I.get<SupabaseClient>(),
        ),
      ),
      child: BlocProvider(
        create: (context) =>
            EESUpoolTypeViewBloc(context.read<EESUpoolRepository>())
              ..add(EESUpoolsTypeViewFetched(type)),
        child: BlocBuilder<EESUpoolTypeViewBloc, EESUpoolTypeViewState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: () {
                if (state is EESUpoolTypeViewLoading) {
                  return const LargeLoadingShimmer();
                }
                if (state is EESUpoolsTypeViewLoaded) {
                  return Column(
                    children: [
                      if (showTopActions)
                        _TypeHeader(
                          type: type,
                          key: const Key('value'),
                          kasiPoolsCount: state.kasiPoolsCount,
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.eesupools.length,
                          itemBuilder: (context, index) {
                            final pool = state.eesupools[index];
                            return EESUpoolCard(eesupool: pool)
                                .animate()
                                .slideIn(
                                  (index + 1) * 50,
                                );
                          },
                        ),
                      ),
                    ],
                  );
                }

                if (state is EESUpoolTypeViewError) {
                  return LargeErrorWidget(exception: state.exception);
                }
              }(),
            );
          },
        ),
      ),
    );
  }
}

class _TypeHeader extends StatelessWidget {
  const _TypeHeader(
      {super.key, required this.kasiPoolsCount, required this.type});
  final int kasiPoolsCount;
  final EESUpoolType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _EESUpoolTypeViewActionBtn(
                  isEnabled: type != EESUpoolType.Kasi,
                  label: 'Create',
                  onPressed: () {}),
              20.sW,
              _EESUpoolTypeViewActionBtn(label: 'Search', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _EESUpoolTypeViewActionBtn extends StatelessWidget {
  const _EESUpoolTypeViewActionBtn({
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
  });
  final String label;
  final bool isEnabled;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: !isEnabled ? null : onPressed,
        child: Opacity(
          opacity: isEnabled ? 1 : .3,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
