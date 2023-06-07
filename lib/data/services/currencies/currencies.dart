import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';
import '../../../core/helpers/shared_prefrencess.dart';

class CurrenciesService {
  final ApiClient _apiClient;

  CurrenciesService(this._apiClient);

  Future<dynamic> getCurrenciesService() async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/productclasses"
      },
    );
    if (response.body.isNotEmpty) {
      print(":::::: ${response.body}");
      print(":::::: ${response.body["data"]}");
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }
}
