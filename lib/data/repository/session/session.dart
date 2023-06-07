import '../../model/session/session.dart';
import '../../services/session/session.dart';

class SessionRepository {
  final SessionService sessionService ;
  SessionRepository({required this.sessionService});



  Future<SessionModel> getSessionRepo() async {
    print("***************************************************** ");
    final data = await sessionService.getSessionId();
    print("data $data");
    return data;
    // if(data != null){
    //   final res =  Future.value(SessionModel.fromJson(data));
    //   return res;
    // }else {
    //   return Future.value(null);
    // }


  }



}