import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/eesupools/ui/tabs/my_kasi_tree/bloc/my_kasi_tree_bloc.dart';
import 'package:ui/src/features/eesupools/ui/widgets/eesupool_card.dart';

class MyKasiTreeTab extends StatelessWidget {
  const MyKasiTreeTab({super.key, required this.pool});
  final EESUpool pool;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyKasiTreeBloc(context.read<EESUpoolRepository>())
        ..add(
          MyKasiTreeFetched(pool.eesupoolId!),
        ),
      child: Column(
        children: [
          Container(
            color: Colors.white.withOpacity(.8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: EESUpTextFormField(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    hintText: 'Search EESUpools',
                    // controller: _searchController,
                    onChanged: (p0) {
                      //  setState(() {});
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Icon(
                        IconlyLight.search,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 15, top: 5),
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MyKasiTreeBloc, MyKasiTreeState>(
            builder: (context, state) {
              if (state is MyKasiTreeLoaded) {
                final pools = state.pools;

                if (pools.isEmpty) {
                  return FullScreenError(
                    exception: EESUpException(
                      message:
                          'This EESUpool does not have other EESUpools in it\'s MyKasiTree',
                    ),
                    isError: false,
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: pools.length,
                    itemBuilder: (context, index) {
                      return EESUpoolCard(
                        eesupool: pools[index],
                      );
                    },
                  ),
                );
              } else if (state is MyKasiTreeLoading) {
                return const FullScreenLoadingShimmer();
              } else if (state is MyKasiTreeError) {
                return FullScreenError(
                  exception: state.exception,
                );
              } else {
                return FullScreenError(exception: EESUpException(message: ''));
              }
            },
          )
        ],
      ),
    );
  }
}
