import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:data/eesupools/repository/eesupool_chats_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  final EESUpool _pool;
  final EESUpoolRepository _repository;
  IssuesCubit(this._pool, this._repository) : super(IssuesLoading()) {
    fetchIssues();
  }

  Future<void> fetchIssues() async {
    emit(IssuesLoading());
    final results = await _repository.fetchIssues(_pool.eesupoolId!, 500);
    results.fold((l) {
      emit(IssuesError(l));
    }, (r) {
      emit(IssuesLoaded(r));
    });
  }
}
