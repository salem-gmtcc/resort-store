import 'package:resort_store/data/model/register/register.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;

  RegisterSuccessState({required this.registerModel});
}

class RegisterErrorState extends RegisterStates {
  String e;

  RegisterErrorState(this.e);
}

class RegisterLoadingState extends RegisterStates {}

class ChangeSecureState extends RegisterStates {}

class ChangeSecureConfirmPassState extends RegisterStates {}
