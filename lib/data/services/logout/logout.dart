import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class LogOutService {
  final ApiClient _apiClient;

  LogOutService(this._apiClient);

  Future<dynamic> getLogOut() async {
    final response = await _apiClient.post(ApiConstants.indexPhp,
        headers: HeaderApis.headers,
        baseUrl: ApiConstants.baseUrl,
        parameters: {
          ApiConstants.route:
              "${ApiConstants.rest}/${ApiConstants.logout}/${ApiConstants.logout}"
        }
        );
    print("response : ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }
}
