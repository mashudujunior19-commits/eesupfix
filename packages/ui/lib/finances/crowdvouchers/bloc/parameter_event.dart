part of 'parameter_bloc.dart';

@immutable
sealed class ParameterEvent {}

final class FetchParametersEvent extends ParameterEvent {}
