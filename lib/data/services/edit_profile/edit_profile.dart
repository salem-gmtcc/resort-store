import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';

import '../../../core/constants/api_constant.dart';
import '../../../core/constants/header.dart';
import '../../network/api_client.dart';

class EditProfileService {
  final ApiClient _apiClient;

  EditProfileService(this._apiClient);

  Future<dynamic> getEditProfileService(Map<String, dynamic> body) async {

    final response = await _apiClient.update(ApiConstants.indexPhp,
        headers:HeaderApis.headers,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/account/account"
        },
        body: body);
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }

  Future<dynamic> changePasswordService(Map<String, dynamic> body) async {

    final response = await _apiClient.update(ApiConstants.indexPhp,
        headers: HeaderApis.headers,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/account/password"
        },
        body: body);
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }
}
