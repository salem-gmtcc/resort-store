import 'package:resort_store/data/model/generic.dart';
import 'package:resort_store/data/services/logout/logout.dart';

class LogoutRepository {
  final LogOutService logOutService;

  LogoutRepository({required this.logOutService});


  Future<dynamic> logOutRepo () async {
    final data = await logOutService.getLogOut();

    if(data != null) {
      return Future.value(GenericModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }



}