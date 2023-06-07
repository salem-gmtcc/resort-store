import 'package:resort_store/data/model/information/information.dart';

abstract class InformationStates {}

class InformationInitStates extends InformationStates {}

class InformationSuccessStates extends InformationStates {
  final InformationModel informationModel ;
  InformationSuccessStates({required this.informationModel});
}

class OneInformationSuccessStates extends InformationStates {
  final OneInformationModel oneInformationModel ;
  OneInformationSuccessStates({required this.oneInformationModel});
}

class InformationErrorStates extends InformationStates {
  String e ;
  InformationErrorStates(this.e);
}

class InformationLoadingStates extends InformationStates {}
