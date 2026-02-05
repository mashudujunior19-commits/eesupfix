import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/finance/data_source/voucher_supabase_dt.dart';
import 'package:data/finance/models/voucher_cycle.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/finances/crowdvouchers/bloc/create_voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/confirm_voucher_dialog.dart';

class NewVoucherScreen extends StatelessWidget {
  NewVoucherScreen({super.key});
  static const route = '/new-voucher';
  final GetIt getIt = GetIt.I;
  final _amountController = TextEditingController();
  final _periodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocProvider(
        create: (context) => CreateVoucherBloc(
          VoucherRepository(
            getIt<AuthRepository>(),
            VoucherSupabaseDt(
              getIt<SupabaseClient>(),
            ),
          ),
        ),
        child: BlocListener<CreateVoucherBloc, CreateVoucherState>(
          listener: (context, state) {
            if (state is CreateVoucherBusyState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('New Voucher'),
            ),
            body: BlocBuilder<CreateVoucherBloc, CreateVoucherState>(
              builder: (context, state) {
                if (state is CreateVoucherCurrentState) {
                  return Container(
                    decoration: context.bgImage,
                    child: Container(
                      width: context.width,
                      height: context.height,
                      color: Colors.white.withOpacity(.5),
                      child: ListView(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: 400,
                        ),
                        children: [
                          EESUpTextFormField(
                            label: 'Amount',
                            type: TextInputType.number,
                            controller: _amountController,
                            hintText: 'Minimum amount is R5000.00.',
                            onChanged: (value) {
                              final voucher = state.voucher.copyWith(
                                value: double.parse(value),
                              );
                              context.read<CreateVoucherBloc>().add(
                                    CreateVoucherUpdatedEvent(voucher),
                                  );
                            },
                          ),
                          EESUpTextFormField(
                            label: 'Period(Months)',
                            type: TextInputType.number,
                            controller: _periodController,
                            hintText: 'Minimum period is 1 months.',
                            onChanged: (value) {
                              final period = int.tryParse(value);
                              if (period != null) {
                                final period = int.parse(value);
                                final weeks = period * 4;
                                final endDate = DateTime.now()
                                    .add(Duration(days: weeks * 7));

                                //with the period calc the end date from now
                                final voucher = state.voucher.copyWith(
                                  period: period,
                                  endDate: endDate.copyWith(
                                    hour: 0,
                                    minute: 0,
                                    second: 0,
                                  ),
                                );
                                context
                                    .read<CreateVoucherBloc>()
                                    .add(CreateVoucherUpdatedEvent(voucher));
                              }
                            },
                          ),
                          10.sH,
                          const Text('End Date'),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: context.width,
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: .5,
                              ),
                            ),
                            child: Text(
                              DateFormatter.formatDateToNameday(
                                  state.voucher.endDate),
                            ),
                          ),
                          15.sH,
                          const Text('Cycle'),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: context.width,
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: .5,
                              ),
                            ),
                            child: DropdownButton<VoucherCycle>(
                              isExpanded: true,
                              underline: const SizedBox(),
                              value: state.voucher.cycle,
                              borderRadius: BorderRadius.circular(10),
                              icon:
                                  const Icon(IconlyLight.arrowDown2, size: 16),
                              style: context.textTheme.labelMedium,
                              items: VoucherCycle.values
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                final voucher = state.voucher.copyWith(
                                  cycle: value,
                                );
                                context.read<CreateVoucherBloc>().add(
                                      CreateVoucherUpdatedEvent(voucher),
                                    );
                              },
                              hint: Text(
                                'Cycle',
                                style: context.textTheme.labelMedium,
                              ),
                            ),
                          ),
                          10.sH,
                          Text(
                            'Weekly : Every week you will get a payout until the end date.',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                            ),
                          ),
                          5.sH,
                          Text(
                            'Monthly : Every month you will get a payout until the end date.',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                            ),
                          ),
                          5.sH,
                          Text(
                            'Once-off : You will get a payout once on the end date.',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                            ),
                          ),
                          25.sH,
                          ElevatedButton(
                            onPressed: () {
                              try {
                                final amount =
                                    double.parse(_amountController.text);
                                if (amount < 3000) {
                                  context.snackBarError(
                                    'Minimum amount is R3000.00 is required.',
                                  );
                                  return;
                                }
                                final period =
                                    int.parse(_periodController.text);
                                if (period < 1) {
                                  context.snackBarError(
                                    'Minimum period is 1 month is required.',
                                  );
                                  return;
                                }
                                context.showBottomSheetDialog(
                                  child: ConfirmVoucherParameterDialog(
                                    voucher: state.voucher,
                                  ),
                                );
                              } catch (e) {
                                context.snackBarError(
                                    'Ensure all fields are filled');
                              }
                            },
                            child: const Text('Proceed'),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
