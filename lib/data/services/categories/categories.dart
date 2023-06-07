import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';


class CategoriesService {

  final ApiClient _apiClient;
  CategoriesService(this._apiClient);



  //TODO : get All Categories
  Future<List<dynamic>> getAllCategories(int page) async {
    final response = await _apiClient.get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers:HeaderApis.headers,
        parameters: {
      ApiConstants.route: "${ApiConstants.feed}/categories",
      "extended":"1",
      "limit":"20",
      "page":page.toString()
    });
    print("************************************************************11${response.body}");
    //print("------------------------------------------------------------ ${json.decode(response.body)['data']}");
    if (response.body.isNotEmpty) {
      final res = response.body['data'];
      print("res ****************----------------------------------------${res.toString()}");
      return Future.value(res);
    } else {
      return Future.value([]);
    }
  }


  //TODO: get Main Categories
  Future<List<dynamic>> getMainCategories() async {
    final response = await _apiClient.get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers:HeaderApis.headers,
        parameters: {
             ApiConstants.route: "${ApiConstants.feed}/categories"
                     });
       print("*******************************88 ${response.body}");
    if (response.body.isNotEmpty) {
      return Future.value(response.body["data"]);
    } else {
      return Future.value([]);
    }
  }


  //TODO: get Sub Categories
  Future<dynamic> getSubCategories(String id) async {
    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
        ApiConstants.route: "${ApiConstants.feed}/categories",
        "id": id
    });

    if (response.body.isNotEmpty) {
      print("------------------------------| |------------------------------");
      return Future.value(response.body);
    } else {
      return Future.value(null);
    }
  }
}
