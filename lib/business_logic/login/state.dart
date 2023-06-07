import 'package:resort_store/data/model/login/login.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final LoginModel loginModel;

  SuccessLoginState({required this.loginModel});
}

class ErrorLoginState extends LoginStates {
  String e;

  ErrorLoginState({required this.e});
}
class ChangeSecureState extends LoginStates {}