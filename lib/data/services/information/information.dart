import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class InformationService {
  final ApiClient _apiClient;

  InformationService(this._apiClient);

  //TODO: get All Information
  Future<dynamic> getInformationService() async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      parameters: {ApiConstants.route: "${ApiConstants.feed}/information"},
      headers: HeaderApis.headers,
      baseUrl: ApiConstants.baseUrl,
    );

    print("response : $response");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO: get  one Information
  Future<dynamic> getOneInformationService(String id) async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      parameters: {ApiConstants.route: "${ApiConstants.feed}/information",
      "id": id
      },
      headers: HeaderApis.headers,
      baseUrl: ApiConstants.baseUrl,
    );

    print("response : $response");

    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }
}
