part of 'member_settings_bloc.dart';

@immutable
sealed class MemberSettingsEvent {}

final class MemberSettingsInitialized extends MemberSettingsEvent {
  final EESUpoolMember member;
  MemberSettingsInitialized(this.member);
}
