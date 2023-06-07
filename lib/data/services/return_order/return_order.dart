import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class ReturnOrderService {
  final ApiClient _apiClient;

  ReturnOrderService(this._apiClient);
 //TODO: GET RETURN ORDER
  Future<dynamic> getReturnOrderService() async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      parameters: {ApiConstants.route: "${ApiConstants.rest}/return/returns"},
      headers: HeaderApis.headers,
    );

    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future.value(null);
    }



  }

  //TODO: GET RETURN ORDER Details
  Future<dynamic> getReturnOrderDetailsService(String returnId) async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      parameters: {ApiConstants.route: "${ApiConstants.rest}/return/returns",
      "id":returnId
      },
      headers: HeaderApis.headers
    );

    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future.value(null);
    }



  }

  //TODO: send RETURN ORDER
  Future<dynamic> sendReturnOrderService(Map<String,dynamic> body) async {

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      body: body,
      parameters: {ApiConstants.route: "${ApiConstants.rest}/return/returns"},
      headers: HeaderApis.headers
    );

    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future.value(null);
    }



  }


  //TODO:  reOrder ORDER
  Future<dynamic> reOrderOrderService(String orderId ,String orderProductId) async {

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      parameters: {ApiConstants.route: "${ApiConstants.rest}/order/orders",
       "id" : orderId,
        "order_product_id" :orderProductId
      },
      headers:HeaderApis.headers
    );

    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future.value(null);
    }



  }

}
