import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/data/model/product/product.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/shared_prefrencess.dart';

class ProductService {
  final ApiClient _apiClient;

  ProductService(this._apiClient);

  //TODO : GET All Products
  Future<dynamic> getAllProductService() async {
    final response = await _apiClient.get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/products",
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : GET Latest
  Future<dynamic> getLatestProductService() async {


    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/latest",
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : GET BestSeller
  Future<dynamic> getBestSellerProductService() async {


    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/bestsellers",
      "limit": "10"
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : GET product Details
  Future<dynamic> getProductDetailsService(String id) async {


    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/products",
      "id": id
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : GET product Related
  Future<dynamic> getProductRelatedService(String id) async {


    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/related",
      "id": id
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : Search in Product
  Future<List<dynamic>> getProductSearchService(String query) async {

    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers,parameters: {
      ApiConstants.route: "${ApiConstants.feed}/products",
      "search": query
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body["data"]);
    } else {
      return Future(() => []);
    }
  }

  //TODO : Get Product By CategoryId

  Future<dynamic> getProductByCategoryIdService(String id) async {
    String? sessionId =
        SharedHelper.sharedPreferences.getString(AppStrings.sessionId);
    String? headerLang =
        SharedHelper.sharedPreferences.getString(AppStrings.languageCode);

    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers,parameters: {
      ApiConstants.route: "${ApiConstants.feed}/products",
      "category": id
    });

    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

  //TODO : Get Featured Product

  Future<List<dynamic>> getFeaturedProductService() async {
     print("**************************** Currency Code ${HeaderApis.currencyCode}");
    final response = await _apiClient.get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl,
        headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/featured",
    });
    print(
        "*****---------------------------------------------------------------------------------------------------------------- ${response.body}");
    if (response.body.isNotEmpty) {
      print("-------------------- response ${response.body}");
      return Future(() => response.body["data"][0]["products"]);
    } else {
      return Future(() => []);
    }
  }

  //TODO : Compare Products

  Future<dynamic> getCompareProductService() async {
    var comparedItems = SharedHelper.sharedPreferences.get("ComparedItems");

    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: HeaderApis.headers, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/compare",
      "ids": comparedItems
    });
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }

/*

  Future<dynamic> removeCompareItemService(String id) async {
    comparedItems = comparedItems.replaceAll(id, "");
    print("------------------------------------------ $comparedItems");
    String? sessionId =
    SharedHelper.sharedPreferences.getString(AppStrings.sessionId);
    final response = await _apiClient
        .get(ApiConstants.indexPhp, baseUrl: ApiConstants.baseUrl, headers: {
      ApiConstants.accept: "application/json",
      ApiConstants.secretKey: "V3OHlbdTjhRBPHvOrgGhmne0v4Ald0T0",
      ApiConstants.sessionId: sessionId!,
    }, parameters: {
      ApiConstants.route: "${ApiConstants.feed}/compare",
      "ids": comparedItems
    });
    print("----------------- ${response.body}");
    if (response.body.isNotEmpty) {
      return Future(() => response.body);
    } else {
      return Future(() => null);
    }
  }
*/

}
