import 'package:resort_store/data/model/generic.dart';

abstract class LogOutStates {}

class LogOutInitState extends LogOutStates {}

class LogOutSuccessState extends LogOutStates {
  final GenericModel genericModel;
  LogOutSuccessState({required this.genericModel});
}

class LogOutErrorState extends LogOutStates {
  String e ;
  LogOutErrorState(this.e);
}

class LogOutLoadingState extends LogOutStates {}
