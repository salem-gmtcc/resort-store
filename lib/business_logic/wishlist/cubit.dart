import 'package:resort_store/business_logic/wishlist/state.dart';
import 'package:resort_store/data/repository/wishlist/wishlist.dart';
import 'package:bloc/bloc.dart';

class WishListCubit extends Cubit<WishListStates> {
  WishListCubit({required this.wishListRepository})
      : super(InitWishListState());

  final WishListRepository wishListRepository;

  //TODO : get WishList
  getWishListCubit() {
    print("***************************************************");
    emit(LoadingWishListState());
    wishListRepository.getWishListRepository().then((value) {
      emit(SuccessWishListState(wishListModel: value));
    }).catchError((e) {
      emit(ErrorWishListState(e.toString()));
    });
  }

  //TODO : send WishList
  sendWishListCubit(String id) {
    emit(LoadingWishListState());
    wishListRepository.sendWishListRepository(id).then((value) {
      emit(SuccessWishListState(wishListModel: value));
    }).catchError((e) {
      emit(ErrorWishListState(e.toString()));
    });
  }

  //TODO : delete WishList
  deleteWishListCubit(String id) {
    emit(LoadingWishListState());
    wishListRepository.deleteWishListRepository(id).then((value) {
      emit(SuccessWishListDeleteState(wishListModel: value));
    }).catchError((e) {
      emit(ErrorWishListState(e.toString()));
    });
  }
}
