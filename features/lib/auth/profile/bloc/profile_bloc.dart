import 'package:bloc/bloc.dart';
import 'package:data_sources/auth/models/profile.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:meta/meta.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepo;
  ProfileBloc(this.profileRepo) : super(ProfileLoading()) {
    on<ProfileFetched>((event, emit) async {
      emit(ProfileLoading());
      final results = await profileRepo.fetchSessionProfile();
      results.fold((l) {}, (r) {
        if (r == null) {
          emit(
            ProfileError(
              EESUpException(message: 'Failed to load your profile.'),
            ),
          );
        } else {
          emit(ProfileLoaded(r));
        }
      });
    });

    on<ProfileReloaded>((event, emit) {
      emit(ProfileLoaded(event.profile));
    });
  }
}
