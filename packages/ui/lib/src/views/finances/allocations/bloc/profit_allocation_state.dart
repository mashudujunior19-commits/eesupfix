part of 'profit_allocation_bloc.dart';

@immutable
sealed class ProfitAllocationState {}

final class ProfitAllocationInitial extends ProfitAllocationState {}

final class ProfitAllocationError extends ProfitAllocationState {
  final EESUpException exception;
  ProfitAllocationError(this.exception);
}

final class ProfitAllocationLoaded extends ProfitAllocationState {
  final ProfitAllocation allocation;
  ProfitAllocationLoaded(this.allocation);


  double calcCIA(double profit, int qty) {
    return (profit * (allocation.cia / 100)) * (qty > 0 ? qty : 1);
  }

  double calcCWA(double profit, int qty) {
    return (profit * (allocation.cwa / 100)) * (qty > 0 ? qty : 1);
  }

  double calcEIA(double profit, int qty) {
    return (profit * (allocation.eia / 100)) * (qty > 0 ? qty : 1);
  }

  double calcCRC(double profit, int qty) {
    return (profit * (allocation.crc / 100)) * (qty > 0 ? qty : 1);
  }

  double calcCSA(double profit, int qty) {
    return (profit * (allocation.csa / 100)) * (qty > 0 ? qty : 1);
  }

  double calcDAA(double profit, int qty) {
    return (profit * (allocation.daa / 100)) * (qty > 0 ? qty : 1);
  }
}
