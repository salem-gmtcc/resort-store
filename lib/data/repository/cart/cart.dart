import 'package:resort_store/data/model/cart/cart.dart';
import 'package:resort_store/data/services/cart/cart.dart';
import 'package:flutter/material.dart';

import '../../model/generic.dart';

class CartRepository {
  final CartService cartService;

  CartRepository({required this.cartService});

  //TODO: get Cart Repository
  Future<dynamic> getCartRepository() async {
    print("************ enter repo ");
    final data = await cartService.getCartService();
    print("****** data${data["data"].runtimeType}");
    print((data["data"].runtimeType is List<dynamic>));

    if (data != null) {
      if((data["data"].runtimeType.toString() == "List<dynamic>") == false)
        {
          print("--------------------------------- ${data["data"]["products"]}");
          return Future.value(CartModel.fromJson(data));
        }
        return Future.value(null);

    } else {
      return Future.value(null);
    }
  }

  //TODO: Empty Cart Repository
  Future<dynamic> emptyCartRepository() async {
    print("************ enter repo ");
    final data = await cartService.getCartService();
    print("****** data$data");

    if (data != null) {
      return Future.value(EmptyCart.fromJson(data));
    } else {
      return Future.value(null);
    }
  }


  //TODO: post Cart Repository
  Future<dynamic> postCartRepository(Map<String,dynamic> body) async {
    print("************ enter repo ");
    final data = await cartService.postCartService(body);
    print("****** data$data");

    if (data != null) {
      return Future.value(SendDataToCart.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO: delete item from Cart Repository
  Future<dynamic> deleteItemFromCartRepository(String key) async {
    print("************ enter repo ");
    final data = await cartService.deleteItemFromCartService(key);
    print("****** data$data");

    if (data != null) {
      return Future.value(CartModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }



  //TODO : Update Item Cart
  Future<dynamic> updateCartRepository(Map<String,dynamic> body ) async{
    print("-------------- ****");
    final data = await cartService.updateItemCartService(body);
    if(data != null){
      return Future.value(GenericModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }

  //TODO: get Coupon
  Future<dynamic> getCouponRepository(String coupon) async {
    final data = await cartService.couponService(coupon);
    if(data != null){
      return Future(() => GenericModel.fromJson(data));
    }else {
      return Future(() => null);
    }
  }

}
