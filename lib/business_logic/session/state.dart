import 'package:resort_store/data/model/session/session.dart';

abstract class SessionState {}

class SessionInitState extends SessionState {}

class SessionSuccessState extends SessionState {
  final SessionModel sessionModel ;
  SessionSuccessState({required this.sessionModel});
}

class SessionErrorState extends SessionState {
  String e;
  SessionErrorState(this.e);
}

class SessionLoadingState extends SessionState {}
