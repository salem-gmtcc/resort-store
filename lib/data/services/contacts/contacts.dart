import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class ContactService {
  final ApiClient _apiClient;

  ContactService(this._apiClient);

  Future<dynamic> sendContactService(Map<String, dynamic> body) async {
    final response = await _apiClient.post(
        ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
        parameters: {
          ApiConstants.route: "${ApiConstants.rest}/contact/send",
        },
        body: body);

    if (response.body.isNotEmpty) {
      print("booooooooby ${response.body}");
      return Future.value(response.body);
    } else {
      return Future(() => null);
    }
  }
}
