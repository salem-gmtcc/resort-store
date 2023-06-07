import 'package:resort_store/business_logic/login/state.dart';
import 'package:resort_store/business_logic/session/state.dart';
import 'package:resort_store/data/repository/session/session.dart';
import 'package:bloc/bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final SessionRepository sessionRepository;

  SessionCubit({required this.sessionRepository}) : super(SessionInitState());

  getSession() {
    // emit(SessionInitState());
    emit(SessionLoadingState());
    sessionRepository.getSessionRepo().then((value) {
      emit(SessionSuccessState(sessionModel: value));
    }).catchError((e) {
      emit(SessionErrorState(e.toString()));
    });
  }
}
