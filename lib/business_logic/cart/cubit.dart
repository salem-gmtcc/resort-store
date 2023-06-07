
import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit({required this.cartRepository}) : super(InitCartState());
  CartRepository cartRepository;

  int _quantity = 1;
  int _count = 0;

  //TODO: get Cart
  getCartCubit() {
    emit(LoadingCartState());
    cartRepository.getCartRepository().then((value) {
      if (value == null) {
        emit(SuccessEmptyCartState());
      } else {
        emit(SuccessGetCartState(cartModel: value));
      }
    }).catchError((e) {
      emit(ErrorCartState(e.toString()));
    });
  }

  //TODO: post Cart
  Future<void> postCartCubit(Map<String, dynamic> body) {
    emit(LoadingCartState());
    cartRepository.postCartRepository(body).then((value) {
      emit(SuccessAddCartState(sendDataToCart: value));
      return Future.value();
    }).catchError((e) {
      print("e");
      // emit(ErrorCartState(e.toString()));
    });
    return Future.value(Duration(seconds: 2));

  }

  //TODO: delete item from  Cart
  deleteItemFromCartCubit(String key) {
    emit(LoadingCartState());
    cartRepository.deleteItemFromCartRepository(key).then((value) {
      emit(SuccessDeleteItemFromCartState(cartModel: value));
    }).catchError((e) {
      emit(ErrorCartState(e.toString()));
    });
  }

  //TODO: empty Cart
  //  emptyCartCubit() {
  //   emit(LoadingCartState());
  //   cartRepository.emptyCartRepository().then((value) {
  //     emit(SuccessEmptyCartState(emptyCart: value));
  //   }).catchError((e) {
  //     emit(ErrorCartState(e.toString()));
  //   });
  // }



  int getQuantity() {
    return _quantity;
  }

  int getCount() {
    return _count;
  }
  increment() {
    _quantity++;
    emit(ChangeQuantityItemState(qty: _quantity));
  }

  decrement() {
    if (_quantity > 1) {
      _quantity--;
    }
    emit(ChangeQuantityItemState(qty: _quantity));
  }

}
