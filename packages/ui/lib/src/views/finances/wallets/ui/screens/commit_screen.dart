// ignore_for_file: use_build_context_synchronously
import 'package:data/finance/models/investment_project.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/models/wallet_rules.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:data/utils/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_dropdown_form_field.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

/// Commit Wealth wallet funds to an approved investment project.
///
/// The recipient is always an investment project, so there is no recipient
/// type. The projects passed in are already limited to those that are approved
/// and open for funding; the database checks that again, along with the
/// R500 minimum balance.
class CommitScreen extends StatefulWidget {
  const CommitScreen({
    super.key,
    required this.wallet,
    required this.availableBalance,
    required this.projects,
  });

  final Wallet wallet;
  final double availableBalance;
  final List<InvestmentProject> projects;

  @override
  State<CommitScreen> createState() => _CommitScreenState();
}

class _CommitScreenState extends State<CommitScreen> {
  final _amountController = TextEditingController();
  InvestmentProject? _project;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final project = _project;
    if (project == null) {
      context.snackBarError('Please select a project');
      return;
    }
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount < 1) {
      context.snackBarError('Please enter a valid amount');
      return;
    }
    if (!canCommitWithBalance(widget.availableBalance)) {
      context.snackBarError(
        'You need more than R${minWealthCommitBalance.toStringAsFixed(0)} in '
        'your Wealth wallet to commit to a project. Current available '
        'balance: R${widget.availableBalance.toRounded()}.',
      );
      return;
    }
    if (amount > widget.availableBalance) {
      context.snackBarError('Insufficient funds!!!');
      return;
    }

    context.showAlertDialog(
      'Confirm commit',
      'Are you sure you want to commit R${amount.toRounded()} to '
          '${project.name}?',
      onNegative: () {},
      negativeColor: context.colorScheme.primary.withOpacity(.5),
      positiveColor: context.colorScheme.primary,
      positiveText: 'Commit',
      negativeText: 'Cancel',
      onPositive: () async {
        context.loaderOverlay.show();
        final result = await context.read<WalletsRepository>().commitToProject(
              fromWalletId: widget.wallet.id,
              projectId: project.id,
              amount: amount,
            );
        context.loaderOverlay.hide();
        result.fold(
          (l) => context.snackBarError(l.message),
          (_) {
            context.snackBarSuccess('Committed to ${project.name}');
            Navigator.pop(context, true);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Commit'),
      ),
      body: SafeArea(
        child: Container(
          decoration: context.bgImage,
          child: Container(
            color: Colors.white.withOpacity(.5),
            child: ListView(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 200),
              children: [
                EESUpDropdownFormField<InvestmentProject>(
                  label: 'Investment project',
                  hintText: 'Select a project',
                  isRequired: true,
                  value: _project,
                  items: widget.projects,
                  itemLabel: (p) => p.name,
                  onChanged: (p) => setState(() => _project = p),
                ),
                EESUpTextFormField(
                  label: 'Amount',
                  hintText: '500.00',
                  type: TextInputType.number,
                  controller: _amountController,
                  isRequired: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 12),
                  child: Text(
                    'Available balance: R${widget.availableBalance.toRounded()}',
                    style: context.textTheme.labelSmall,
                  ),
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Commit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
