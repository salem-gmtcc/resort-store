import 'package:resort_store/data/model/return_order/return_order.dart';
import 'package:resort_store/data/services/order/order.dart';

import '../../model/order/confirm_order.dart';

class ConfirmOrderRepository {
  final ConfirmOrderService confirmOrderService;

  ConfirmOrderRepository({required this.confirmOrderService});


  // TODO: get All Orders
  Future<dynamic> getOrdersRepository() async {
    final data = await confirmOrderService.getOrdersService();
    if (data != null) {
      return Future.value(GetOrderModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  // TODO: get order Details by id
  Future<dynamic> getOrderDetailsRepository(String orderId) async {
    final data = await confirmOrderService.getOrderDetailsService(orderId);
    if (data != null) {
      print("********* data  $data");
      return Future.value(OrderDetailsModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }


  // TODO: first Confirm Order
  Future<dynamic> getConfirmOrderRepository() async {
    print("********* / ***** enter confirm repo !");
    final data = await confirmOrderService.getConfirmOrder();
    print("****------***********----- data $data");
    if (data != null) {
      return Future.value(ConfirmOrderModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO :  FINAL Confirm Order
  Future<dynamic> getFinalConfirmOrderRepository() async {
    print("********* / ***** enter confirm repo !");
    final data = await confirmOrderService.getConfirmFinalOrder();
    print("****------***********----- data $data");
    if (data != null) {
      return Future.value(ConfirmOrderModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }



  //TODO: re Order Order Repository
  Future<dynamic> reorderOrderRepository(String orderId, String orderProductId) async {
    print("****************** enter repo ***********");
    final data = await confirmOrderService.reorderOrderService(orderId, orderProductId);
    print("****------***********----- data $data");
    if (data != null) {
      return Future.value(ReorderOrderModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO: send Order return
  Future<dynamic> sendOrderReturnRepository(Map<String,dynamic> body) async {
    final data = await confirmOrderService.sendReturnOrderService(body);
    if (data != null) {
      return Future.value(SendOrderReturnDataModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }


 }