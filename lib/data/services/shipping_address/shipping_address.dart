import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class ShippingAddressService {
  final ApiClient _apiClient ;
  ShippingAddressService(this._apiClient);


  //TODO: Add New Address Service
  Future<dynamic> getShippingAddressService(Map<String,dynamic> body) async{

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
      body: body,
        parameters: {
          ApiConstants.route:
          "${ApiConstants.rest}/guest_shipping/guestshipping"
        }
    );
    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future(() => null);
    }
  }

  //TODO: Get All Address Service
  Future<dynamic> getAddressService() async{


    final response = await _apiClient.get(
        ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        parameters: {
          ApiConstants.route:
          "${ApiConstants.rest}/account/address"
        }
    );
    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else {
      return Future(() => null);
    }
  }


}