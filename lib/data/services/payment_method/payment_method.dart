import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class PaymentMethodsService {
  final ApiClient _apiClient;

  PaymentMethodsService(this._apiClient);

  //TODO: Get Payment Methods Service
  Future<dynamic> getPaymentMethodsService() async {
    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        parameters: {
      ApiConstants.route: "${ApiConstants.rest}/payment_method/payments",
    }
    );

    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO: send Payment Methods Service
  Future<dynamic> sendPaymentMethodsService(Map<String, dynamic> body) async {

    final response = await _apiClient.post(ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        body: body,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/payment_method/payments",
        });
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO: final pay methods Service

  Future<dynamic>  finalPayMethodService() async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/confirm/confirm",
          "page":"pay"
        }
    );

    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future(() => null);
    }

  }

}
