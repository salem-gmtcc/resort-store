import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class CountryService {
  final ApiClient _apiClient;

  CountryService(this._apiClient);

  //TODO:  get List Of Country
  Future<dynamic> getCountryService() async {
    final response = await _apiClient.get(ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/countries"
      },
    );
    print("-----------------------------------------------------------------* response.body ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

  //TODO: get Zones by Id

  Future<dynamic> getZonesByIdService(String countryId ) async {
    final response = await _apiClient.get(ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/countries",
        "id": countryId
      },
    );
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

}
