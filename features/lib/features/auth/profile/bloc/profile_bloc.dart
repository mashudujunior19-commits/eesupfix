import 'package:bloc/bloc.dart';
import 'package:data_sources/auth/models/profile.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepo;
  ProfileBloc(this.profileRepo) : super(ProfileInitial()) {
    on<ProfileFetched>((event, emit) async {});
  }
}
