import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/model/login/login.dart';
import 'package:resort_store/data/services/login/login.dart';

class LoginRepo {
  final LoginServices loginServices;

  LoginRepo({required this.loginServices});

  Future<dynamic> getLoginRepo(Map<String, dynamic> body) async {
    final data = await loginServices.loginService(body);
   print("data : $data");
    if (data.body != null) {

      //var myResponse  = response;
      print("response : ${data.body}");
      print("Header Session ${data.headers['set-cookie']}");

      var responseSessionId = data.headers['set-cookie'] as String;
      responseSessionId =  responseSessionId.replaceAll("OCSESSID=", "");
      List<String> sessionIdArr = responseSessionId.split(";");
      print(responseSessionId);
      if(sessionIdArr.isNotEmpty)
        {
          print("********************   ---------  ${sessionIdArr[0]}");
          SharedHelper.sharedPreferences.setInt(AppStrings.loginType, 1);

          SharedHelper.sharedPreferences.setString(AppStrings.sessionId, sessionIdArr[0]);
        }

      return Future.value(LoginModel.fromJson(data.body));
    } else {
      return Future.value(null);
    }
  }
}
