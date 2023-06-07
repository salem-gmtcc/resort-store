import 'package:resort_store/data/model/order/confirm_order.dart';

abstract class OrderStates {}

class OrderInitState extends OrderStates {}

//TODO: CONFIRM ORDER
class OrderSuccessState extends OrderStates {
  final ConfirmOrderModel confirmOrderModel;

  OrderSuccessState({required this.confirmOrderModel});
}

//TODO: GET ALL ORDERS
class GetAllOrdersSuccessState extends OrderStates {
  final GetOrderModel getOrderModel;

  GetAllOrdersSuccessState({required this.getOrderModel});
}

//TODO: GET Details Order
class GetDetailsOrdersSuccessState extends OrderStates {
  final OrderDetailsModel orderDetailsModel;

  GetDetailsOrdersSuccessState({required this.orderDetailsModel});
}

class FinalOrderSuccessState extends OrderStates {}

class OrderErrorState extends OrderStates {
  String? e;

  OrderErrorState(this.e);
}

class OrderLoadingState extends OrderStates {}

//TODO : REORDER ORDER
class ReOrderOrderState extends OrderStates {
  final ReorderOrderModel reorderOrderModel;

  ReOrderOrderState({required this.reorderOrderModel});
}

//TODO : send return Order
class SendReturnOrderState extends OrderStates {
  final SendOrderReturnDataModel sendOrderReturnDataModel ;
  SendReturnOrderState({required this.sendOrderReturnDataModel});
}
