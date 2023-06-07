import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../model/payment_address/payment_address.dart';

class PaymentAddressService {
  final ApiClient _apiClient;

  PaymentAddressService(this._apiClient);


  //TODO : get All Payment Address
  Future<dynamic> getAllPaymentAddressService() async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route:
            "${ApiConstants.rest}/payment_address/paymentaddress",
      },
      baseUrl: ApiConstants.baseUrl,
    );

    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

  //TODO : send Existing Payment Address
  Future<dynamic> sendExistingPaymentAddressService(String addressId) async {
    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      body: {
        "address_id" : addressId
      },
      parameters: {
        ApiConstants.route:
        "${ApiConstants.rest}/payment_address/paymentaddress",
        "existing":addressId
      },
      baseUrl: ApiConstants.baseUrl,
    );

    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

  //TODO : Save New Payment Address
  Future<dynamic> saveNewPaymentAddressService(Map<String,dynamic> body) async {
    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      headers:HeaderApis.headers,
      body: body,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/payment_address/paymentaddress",
      },
      baseUrl: ApiConstants.baseUrl,
    );
    print("*******---------- ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

}
