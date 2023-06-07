import 'dart:convert';

import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/model/getCalculations/getCalculations.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/shared_prefrencess.dart';

class GetCalculationServices {
  final ApiClient _apiClient ;

  GetCalculationServices(this._apiClient);


  Future<dynamic> getCalculationService(String productId,CalculationBody calculationBody) async {


    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      body: calculationBody.toJson(),
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/getCalculations",
        "product_id": productId
      },
    );
    if(response.body.isNotEmpty){
      print("-________________- ${response.body}");
      return Future.value(response.body);
    }else {
      return Future.value(null);
    }


  }

}