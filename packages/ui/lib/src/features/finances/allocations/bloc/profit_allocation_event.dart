part of 'profit_allocation_bloc.dart';

@immutable
sealed class ProfitAllocationEvent {}


final class ProfitAllocationsFetched extends ProfitAllocationEvent{}