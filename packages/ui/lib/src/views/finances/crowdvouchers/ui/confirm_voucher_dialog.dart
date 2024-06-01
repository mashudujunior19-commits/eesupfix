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

                // if (state is CreateVoucherSuccessState) {
                //   final id = state.voucherId;
                //   final amount = voucher.value;

                //   selectPaymentMethodIDialog(context).then((value) {
                //     if (value == PaymentMethod.instapay) {
                //       var now = DateTime.now();
                //       var formatter = DateFormat('yyyy-MM-dd');
                //       String formattedDate = formatter.format(now);
                //       const merchantId = 'e8aff31a-1aaf-4271-8ade-88395d214071';
                //       const accountUUid =
                //           '9370832a-ce36-43d6-83f3-e14d611bc2de';
                //       const sendbox = 'https://webpay-sandbox.omnea.co.za';
                //       const authKey =
                //           'eesup_iyxjp1tlR2rClGJZUK6B0ZqBs8CR9hjqrJM3PrABKQEq';
                //       const secret = '33SuP@2024';
                //       const successUrl =
                //           'https://eesup.com/wp-content/payment_failed.php';
                //       const failedUrl =
                //           'https://eesup.com/wp-content/payment_success.php';
                //       const notifyUrl =
                //           'https://eesup-dart-frog-dev-api-hz7p5cleia-uc.a.run.app/v1/payments/insta_pay';

                //       // if (sendbox == null ||
                //       //     merchantId == null ||
                //       //     accountUUid == null ||
                //       //     authKey == null ||
                //       //     secret == null ||
                //       //     successUrl == null ||
                //       //     failedUrl == null ||
                //       //     notifyUrl == null) {
                //       //   context.snackBarError(
                //       //     'Failed to initiat the payment, if the problem persists, please contact support.',
                //       //   );
                //       //   return;
                //       // }

                //       final transaction = MerchantTransaction(
                //         mUuid: merchantId,
                //         mAccountUuid: accountUUid,
                //         mTxOrderNr: 'EES12345678967432134',
                //         mTxId: '9370832a-ce36-43d6-83f3-e14d611bc2de',
                //         mTxCurrency: 'ZAR',
                //         mCategory1: id.toString(),
                //         mCategory2: 'Voucher',
                //         mCategory3: authKey,
                //         mTxAmount: amount.toStringAsFixed(2),
                //         mTxItemName: 'Crowdfund Voucher Payment',
                //         mTxItemDescription: 'Crowdfund Voucher Payment',
                //         secret: secret,
                //         mEftAllowed: true,
                //         mCardAllowed: true,
                //         mPassAllowed: false,
                //         mChipsAllowed: false,
                //         mPayatAllowed: false,
                //         mTridentAllowed: false,
                //         mTxDueDate: formattedDate,
                //         mMessage: 'Payment for Crowdfund Voucher Payment',
                //         mSiteName: 'EESUp',
                //         bName: 'Joe',
                //         bSurname: 'Soap',
                //         bEmail: 'misomenze6@gmail.com',
                //         bMobile: '+2719582572',
                //         mReturnUrl: successUrl,

                //         mBack2shopUrl: failedUrl,
                //         mNotifyUrl: notifyUrl,
                //         sendboxUrl: sendbox,
                //       );

                //       context
                //           .push(InstapayScreen.route, extra: transaction)
                //           .then((value) {
                //         context.snackBarSuccess(
                //           'Payment is being finalizd, this should only take a few seconds.',
                //         );
                //         if (value == true) {
                //           context.pop();
                //           context.pop();
                //         } else {
                //           context.pop();
                //           context.pop();
                //         }
                //       });
                //     } else if (value == PaymentMethod.ozow) {
                //       context.push(
                //         OzowPaymentScreen.route,
                //         extra: (
                //           reference: id,
                //           amount: amount,
                //           bankRef: 'EESUp voucher-$id',
                //           type: 'Voucher'
                //         ),
                //       ).then((value) {
                //         if ((value as OzowStatus) == OzowStatus.complete) {
                //           context.snackBarSuccess(
                //             'Payment successful, voucher created.',
                //           );
                //           context.pop();
                //           context.pop();
                //         } else {
                //           context.snackBarError('Failed to process payment.');
                //         }
                //       });
                //     }
                //   });
                // }
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
                              text: 'R${voucher.value.toStringAsFixed(2)}',
                            ),
                          ),
                          EESUpTextFormField(
                            readOnly: true,
                            label: 'Profit Share(%)',
                            controller: TextEditingController(
                              text: parameter.interest.toStringAsFixed(2),
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
