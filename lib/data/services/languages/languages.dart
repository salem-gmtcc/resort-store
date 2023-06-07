import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';
import '../../model/languages/languages.dart';

class LanguagesService {
  final ApiClient _apiClient;

  LanguagesService(this._apiClient);

  //TODO: GET ALL LANGUAGES
  Future<dynamic> getLanguagesService() async {
    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/languages",
      },
    );
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }

//TODO: GET ONLY LANGUAGE
  Future<dynamic> getLanguageService(String id) async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.feed}/languages",
        "id": id
      },
    );
    if (response.body.isNotEmpty) {
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }
}
