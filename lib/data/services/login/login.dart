import 'dart:io';

import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/network/api_response.dart';

import '../../../core/constants/api_constant.dart';
import '../../../core/constants/header.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../network/api_client.dart';

class LoginServices {
  final ApiClient apiClient;

  LoginServices(this.apiClient);

  Future<ApiResponse> loginService(Map<String, dynamic> body) async {

    final response = await apiClient.post(
      ApiConstants.indexPhp,
      headers: HeaderApis.headers,
      body: body,
      parameters: {
        ApiConstants.route:
            "${ApiConstants.rest}/${ApiConstants.login}/${ApiConstants.login}"
      },
      baseUrl: ApiConstants.baseUrl,
    );
    print("sssssssssss ");
    if (response.body.isNotEmpty) {
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
}
