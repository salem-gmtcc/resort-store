
import 'package:resort_store/data/services/wishlist/wishlist.dart';

import '../../model/shipping_address/shipping_address.dart';
import '../../model/wishlist/wishlist.dart';

class WishListRepository {
  final WishListService wishListService;

  WishListRepository({required this.wishListService});

  //TODO : get Wish List
  Future<dynamic> getWishListRepository() async {
    final data = await wishListService.getWishListService();
    if (data != null) {
      return Future.value(WishListModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }
  //TODO : send Wish List
  Future<dynamic> sendWishListRepository(String id) async {
    final data = await wishListService.sendWishListService(id);
    if (data != null) {
      return Future.value(WishListModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

  //TODO : delete Wish List
  Future<dynamic> deleteWishListRepository(String id) async {
    final data = await wishListService.deleteWishListService(id);
    if (data != null) {
      return Future.value(WishListModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

}