import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_issue_event.dart';
part 'create_issue_state.dart';

class CreateIssueBloc extends Bloc<CreateIssueEvent, CreateIssueState> {
  CreateIssueBloc() : super(CreateIssueInitial()) {
    on<CreateIssueEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
