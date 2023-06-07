import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/network/api_client.dart';
import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';

import '../../../core/helpers/shared_prefrencess.dart';

class BannerService {
  final ApiClient _apiClient;

  BannerService(this._apiClient);

  Future<dynamic> getBannerService(String id) async {
    print("**************** enter here");
    final response = await _apiClient.get(
        ApiConstants.indexPhp,
        baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/banners",
        "id":"7"
      },
    );
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }
}

