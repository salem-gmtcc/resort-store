import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/api_constant.dart';
import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/shared_prefrencess.dart';

class   CartService {
  final ApiClient _apiClient;
  CartService (this._apiClient);


  //TODO: post  Cart
  Future<dynamic> postCartService(Map<String,dynamic> body) async {
    final response = await _apiClient.post(
        ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        body: body,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/${ApiConstants.cart}/${ApiConstants.cart}",
        });
    print("*****${response.body}");
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }


  //TODO: get All Cart
  Future<dynamic> getCartService() async {
    print("********** enter service ");
    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers:HeaderApis.headers,
        parameters: {
      ApiConstants.route: "${ApiConstants.rest}/${ApiConstants.cart}/${ApiConstants.cart}",
    });
    print("*****${response.body}");
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }


  }

  //TODO : Delete item from cart
  Future<dynamic> deleteItemFromCartService(String key) async {

    final response = await _apiClient.delete(
        ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/${ApiConstants.cart}/${ApiConstants.cart}",
          "key":key
        });
    print("*****${response.body}");
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

//TODO: get coupon
  Future<dynamic> couponService(String coupon) async {

    final response = await _apiClient.post(
        ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        body: {
          "coupon":coupon
        },
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/${ApiConstants.cart}/coupon",
        });
    print("*****${response.body}");
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }


  }



}