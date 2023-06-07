import 'package:resort_store/data/model/cart/cart.dart';

abstract class CartStates {}

class InitCartState extends CartStates {}

//TODO: GET ALL  CART
class SuccessGetCartState extends CartStates {
  final CartModel cartModel;

  SuccessGetCartState({required this.cartModel});
}

//TODO: Empty Cart
class SuccessEmptyCartState extends CartStates {}

//TODO: POST ITEM TO CART
class SuccessAddCartState extends CartStates {
  final SendDataToCart sendDataToCart;

  SuccessAddCartState({required this.sendDataToCart});
}

//TODO: DELETE ITEM FROM CART
class SuccessDeleteItemFromCartState extends CartStates {
  final CartModel cartModel;

  SuccessDeleteItemFromCartState({required this.cartModel});
}

//TODO: GET COUPON
class SuccessCouponState extends CartStates {}

class ErrorCartState extends CartStates {
  final String error;

  ErrorCartState(this.error);
}

class LoadingCartState extends CartStates {}

class ChangeQuantityItemState extends CartStates {
  int qty;

  ChangeQuantityItemState({required this.qty});
}

class ChangeItemCountState extends CartStates {
  int count;
  ChangeItemCountState(this.count);
}
