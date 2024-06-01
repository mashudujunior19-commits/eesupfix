import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/finance/data_source/voucher_supabase_dt.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/finances/crowdvouchers/bloc/voucher_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'voucher_info_and_ledger_view.dart';

@RoutePage()
class VoucherViewScreen extends StatelessWidget {
  VoucherViewScreen({super.key, required this.voucherId});
  static const route = '/voucher-view';
  final int voucherId;
  final getIt = GetIt.I;

  @override
  Widget build(BuildContext context) {
    final repo = VoucherRepository(
      getIt<AuthRepository>(),
      VoucherSupabaseDt(
        getIt<SupabaseClient>(),
      ),
    );
    return BlocProvider(
      create: (context) => VoucherViewBloc(repo)
        ..add(
          FetchVoucherDetailsEvent(voucherId),
        ),
      child: SafeArea(
        child: BlocListener<VoucherViewBloc, VoucherViewState>(
          listener: (context, state) {
            if (state is VoucherViewBusyState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: BlocBuilder<VoucherViewBloc, VoucherViewState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  leading: const BackButton(),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Track Voucher'),
                      10.sW,
                      Icon(
                        Icons.track_changes_rounded,
                        color: context.colorScheme.primary,
                        size: 15,
                      )
                    ],
                  ),
                ),
                body: Container(
                  height: context.height,
                  width: context.width,
                  decoration: context.bgImage,
                  child: () {
                    if (state is VoucherViewDetailsLoadedState) {
                      return InfoAndLedgerView(
                        voucher: state.voucher,
                        ledgers: state.ledgers,
                        parameter: state.parameter,
                        transactions: state.transactions,
                      );
                    }
                    return 0.sW;
                  }(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
