import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class RegisterService {

  final ApiClient _apiClient;
  RegisterService(this._apiClient);

  Future<dynamic> getRegisterService(Map<String, dynamic> body) async {

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      body: body,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route:
        "${ApiConstants.rest}/${ApiConstants.register}/${ApiConstants.register}"
      },
      baseUrl: ApiConstants.baseUrl,
    );
    print("||||||||| response ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    }
    else {
      return Future.value(null);
    }
  }
}
