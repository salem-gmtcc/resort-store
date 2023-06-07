import 'dart:convert';
import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../core/constants/header.dart';

class ConfirmOrderService {
  final ApiClient _apiClient;

  ConfirmOrderService(this._apiClient);

  //TODO: Get All Orders
  Future<dynamic> getOrdersService() async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      baseUrl: ApiConstants.baseUrl,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/order/orders",
        "limit": "10",
        "page": "1"
      },
    );
    print("***** response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      print("******** error ");
      return Future.value(null);
    }
  }

  //TODO: Get Order Details By Id
  Future<dynamic> getOrderDetailsService(String orderId) async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      baseUrl: ApiConstants.baseUrl,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/order/orders",
        "id": orderId
      },
    );
    print("response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

  Future<dynamic> getConfirmOrder() async {

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      baseUrl: ApiConstants.baseUrl,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/simple_confirm/confirm"
      },
    );
    print("***** response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      print("******** error ");
      return Future.value(null);
    }
  }

  Future<dynamic> getConfirmFinalOrder() async {

    String? url =
        "https://sparepart.e-amwaj.com/index.php?route=rest/confirm/confirm";
    Response response = await http.put(
      Uri.parse(url),
      headers:HeaderApis.headers,
    );
    if (response.body.isNotEmpty) {
      return Future.value(jsonDecode(response.body));
    } else {
      return Future.value(jsonDecode(response.body)["error"][0]);
    }
  }

  //TODO: RE ORDER ORDER Service
  Future<dynamic> reorderOrderService(
      String orderId, String orderProductId) async {
    final response = await _apiClient
        .post(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers:HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.rest}/order/orders",
      "id": orderId,
      "order_product_id": orderProductId
    });

    print("***** response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      print("******** error ");
      return Future.value(null);
    }
  }

  //TODO: Send Return Order
  Future<dynamic> sendReturnOrderService(Map<String,dynamic> body) async {

    final response = await _apiClient
        .post(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,headers:  HeaderApis.headers
        ,body: body,
        parameters: {
      ApiConstants.route: "${ApiConstants.rest}/return/returns",
    });

    print("***** response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      print("******** error ");
      return Future.value(null);
    }
  }
}
