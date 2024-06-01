part of 'parameter_bloc.dart';

@immutable
sealed class ParameterState {}

final class ParameterLoading extends ParameterState {}

final class ParameterError extends ParameterState {
  final EESUpException exception;
  ParameterError(this.exception);
}

final class ParametersState extends ParameterState {
  final List<VoucherParameter> parameters;
  ParametersState(this.parameters);

  VoucherParameter findCorrectParameter(int period, double newAmount) {
    final currentParams = [...parameters];
    currentParams.sort((a, b) {
      final periodDiffA = (a.period - period).abs();
      final periodDiffB = (b.period - period).abs();
      final amountDiffA = (a.minimumValue - newAmount).abs();
      final amountDiffB = (b.minimumValue - newAmount).abs();
      return periodDiffA.compareTo(periodDiffB) == 0
          ? amountDiffA.compareTo(amountDiffB)
          : periodDiffA.compareTo(periodDiffB);
    });
    try {
      final p = currentParams.firstWhere(
        (next) => newAmount >= next.minimumValue,
      );
      return p;
    } catch (e) {
      return currentParams.first;
    }
  }
}
