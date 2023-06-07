import 'package:resort_store/data/model/return_order/return_order.dart';

import '../../data/model/order/confirm_order.dart';

abstract class ReturnOrderStates {}

class InitReturnOrderState extends ReturnOrderStates {}

class ErrorReturnOrderState extends ReturnOrderStates {
  String? error;
  ErrorReturnOrderState(this.error);
}

class LoadingReturnOrderState extends ReturnOrderStates {}

//TODO :  SUCCESS GET RETURN ORDER
class SuccessReturnOrderState extends ReturnOrderStates {
  final ReturnOrderModel returnOrderModel;
  SuccessReturnOrderState({required this.returnOrderModel});
}

//TODO :  SUCCESS GET RETURN ORDER DETAILS
class SuccessReturnOrderDetailsState extends ReturnOrderStates {
  final ReturnOrderDetailsModel returnOrderDetailsModel;
  SuccessReturnOrderDetailsState ({required this.returnOrderDetailsModel});
}


//TODO :  SUCCESS SEND RETURN ORDER
class SuccessSendReturnOrderState extends ReturnOrderStates {
  final SendOrderReturnDataModel sendOrderReturnDataModel;
  SuccessSendReturnOrderState({required this.sendOrderReturnDataModel});
}


//TODO :  SUCCESS reOrder  ORDER
class SuccessReOrderOrderState extends ReturnOrderStates {
  final ReorderOrderModel reorderOrderModel;
  SuccessReOrderOrderState({required this.reorderOrderModel});
}
