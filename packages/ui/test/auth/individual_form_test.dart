import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/src/views/auth/register/cubit/register_cubit.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';
import 'package:ui/src/views/auth/register/ui/individual_form.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

/// Mirrors how RegisterScreen hosts the form: a cubit above a TabBarView.
class _Host extends StatefulWidget {
  const _Host();

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterForm>(
      builder: (context, state) => Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabs,
          children: [
            IndividualForm(tabController: _tabs, form: state),
            const Text('step two'),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('a typed first name is kept when Next is tapped', (tester) async {
    final repo = _MockAuthRepository();
    final cubit = RegisterCubit(repo);

    await tester.pumpWidget(
      MaterialApp(
        home: RepositoryProvider<AuthRepository>.value(
          value: repo,
          child: BlocProvider.value(value: cubit, child: const _Host()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Test');
    await tester.pumpAndSettle();

    expect(cubit.state.firstName, 'Test', reason: 'cubit after typing');

    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(cubit.state.firstName, 'Test', reason: 'cubit after tapping Next');
    expect(find.text('Please provide your first name'), findsNothing);
    expect(find.text('Please provide your last name'), findsOneWidget);

    // Let the snack bar's dismiss timer run out before the test ends.
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
  });

  testWidgets('fields filled before the next frame are all kept',
      (tester) async {
    final repo = _MockAuthRepository();
    final cubit = RegisterCubit(repo);

    await tester.pumpWidget(
      MaterialApp(
        home: RepositoryProvider<AuthRepository>.value(
          value: repo,
          child: BlocProvider.value(value: cubit, child: const _Host()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // No pump in between, as with autofill: the form has not rebuilt when
    // the second field changes.
    await tester.enterText(find.byType(TextFormField).at(0), 'Test');
    await tester.enterText(find.byType(TextFormField).at(1), 'User');

    expect(cubit.state.firstName, 'Test');
    expect(cubit.state.lastName, 'User');

    await tester.pumpAndSettle();
  });
}
