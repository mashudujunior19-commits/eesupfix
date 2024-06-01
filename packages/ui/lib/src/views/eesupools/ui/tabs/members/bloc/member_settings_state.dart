part of 'member_settings_bloc.dart';

@immutable
sealed class MemberSettingsState {}

final class MemberSettingsLoading extends MemberSettingsState {}

final class MemberSettingsLoaded extends MemberSettingsState {
  final EESUpoolMember member;
  MemberSettingsLoaded(this.member);
}
