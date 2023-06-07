import '../../../core/constants/api_constant.dart';
import '../../../core/constants/header.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../network/api_client.dart';

class WishListService {
  final ApiClient _apiClient;

  WishListService(this._apiClient);
  //TODO : get Wish List
  Future<dynamic> getWishListService() async {

    final response = await _apiClient.get(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/wishlist/wishlist"
      },
    );
    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else{
      return Future(() => null);
    }
  }

  //TODO : send Wish List
  Future<dynamic> sendWishListService(String id) async {

    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/wishlist/wishlist",
        "id":id
      },
    );
    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else{
      return Future(() => null);
    }
  }


  //TODO : delete Wish List
  Future<dynamic> deleteWishListService(String id) async {

    final response = await _apiClient.delete(
      ApiConstants.indexPhp,
      baseUrl: ApiConstants.baseUrl,
      headers: HeaderApis.headers,
      parameters: {
        ApiConstants.route: "${ApiConstants.rest}/wishlist/wishlist",
        "id":id
      },
    );
    if(response.body.isNotEmpty){
      return Future.value(response.body);
    }else{
      return Future(() => null);
    }
  }

}
