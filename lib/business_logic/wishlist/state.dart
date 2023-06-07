import 'package:resort_store/data/model/wishlist/wishlist.dart';

abstract class WishListStates {}

class InitWishListState extends WishListStates {}

class SuccessWishListState extends WishListStates {
  final WishListModel wishListModel;
  SuccessWishListState({required this.wishListModel});
}

class ErrorWishListState extends WishListStates {
  String? error;

  ErrorWishListState(this.error);
}

class SuccessWishListDeleteState extends WishListStates {
  final WishListModel wishListModel;
  SuccessWishListDeleteState({required this.wishListModel});
}

class LoadingWishListState extends WishListStates {}
