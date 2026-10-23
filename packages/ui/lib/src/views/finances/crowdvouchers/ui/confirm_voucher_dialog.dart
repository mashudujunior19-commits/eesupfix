import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/finance/data_source/voucher_supabase_dt.dart';
import 'package:data/finance/models/voucher.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/finances/crowdvouchers/bloc/create_voucher_bloc.dart';
import 'package:ui/src/views/finances/crowdvouchers/bloc/parameter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:data/utils/double_ext.dart';

class ConfirmVoucherParameterDialog extends StatelessWidget {
  const ConfirmVoucherParameterDialog({super.key, required this.voucher});
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    final repo = VoucherRepository(
      GetIt.I<AuthRepository>(),
      VoucherSupabaseDt(GetIt.I<SupabaseClient>()),
    );

    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ParameterBloc(repo)..add(FetchParametersEvent()),
          ),
          BlocProvider(
            create: (context) => CreateVoucherBloc(repo),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ParameterBloc, ParameterState>(
              listener: (context, state) {
                if (state is ParameterLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
              },
            ),
            BlocListener<CreateVoucherBloc, CreateVoucherState>(
              listener: (context, state) {
                if (state is CreateVoucherBusyState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }

                if (state is CreateVoucherErrorState) {
                  context.snackBarError(state.exception.message);
                }

              },
            ),
          ],
          child: BlocBuilder<ParameterBloc, ParameterState>(
              builder: (context, state) {
            if (state is ParameterError) {
              return FullScreenError(exception: state.exception);
            }

            if (state is ParametersState) {
              final parameter = state.findCorrectParameter(
                voucher.period,
                voucher.value,
              );
              return Container(
                margin: EdgeInsets.only(top: context.height * 0.08),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Scaffold(
                  appBar: AppBar(
                    leading: const BackButton(),
                    title: const Text('Review voucher'),
                  ),
                  body: Container(
                    decoration: context.bgImage,
                    child: Container(
                      width: context.width,
                      height: context.height,
                      color: Colors.white.withOpacity(.5),
                      child: ListView(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 400,
                        ),
                        children: [
                          EESUpTextFormField(
                            readOnly: true,
                            label: 'Amount',
                            controller: TextEditingController(
                              text: 'R${voucher.value.toRounded()}',
                            ),
                          ),
                          EESUpTextFormField(
                            readOnly: true,
                            label: 'Profit Share(%)',
                            controller: TextEditingController(
                              text: parameter.interest.toRounded(),
                            ),
                          ),
                          EESUpTextFormField(
                            label: 'Cycle',
                            readOnly: true,
                            controller: TextEditingController(
                              text: voucher.cycle.toString(),
                            ),
                          ),
                          EESUpTextFormField(
                            readOnly: true,
                            label: 'Period(Months)',
                            controller: TextEditingController(
                              text: '${voucher.period}',
                            ),
                          ),
                          EESUpTextFormField(
                            label: 'End Date',
                            readOnly: true,
                            controller: TextEditingController(
                              text: DateFormatter.formatDateToNameday(
                                voucher.endDate,
                              ),
                            ),
                          ),
                          25.sH,
                          ElevatedButton(
                            onPressed: () {
                              context.read<CreateVoucherBloc>().add(
                                    SubmitVoucherEvent(
                                      voucher.copyWith(
                                        parameterId: parameter.id,
                                      ),
                                    ),
                                  );
                            },
                            child: const Text('Proceed'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
