import 'package:resort_store/data/services/return_order/return_order.dart';

import '../../model/order/confirm_order.dart';
import '../../model/return_order/return_order.dart';

class ReturnOrderRepository {
  final ReturnOrderService returnOrderService ;
  ReturnOrderRepository({required this.returnOrderService});

  // TODO : get Return Order
  Future<dynamic> getReturnOrderRepository() async {
    final data = await returnOrderService.getReturnOrderService();
    if(data != null){
      return Future.value(ReturnOrderModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }


  // TODO : get Return Order  Details
  Future<dynamic> getReturnOrderDetailsRepository(String returnId) async {
    final data = await returnOrderService.getReturnOrderDetailsService(returnId);
    if(data != null){
      return Future.value(ReturnOrderDetailsModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }


  // TODO : send Return Order
  Future<dynamic> sendReturnOrderDetailsRepository(Map<String,dynamic> body) async {
    final data = await returnOrderService.sendReturnOrderService(body);
    if(data != null){
      return Future.value(ReturnOrderDetailsModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }

  // TODO : reorder  Order
  Future<dynamic> reOrderOrderDetailsRepository(String orderId ,String orderProductId) async {
    final data = await returnOrderService.reOrderOrderService(orderId,orderProductId);
    if(data != null){
      return Future.value(ReorderOrderModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }

}