import 'package:resort_store/data/model/generic.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit({required this.cartRepository}) : super(CouponInitial());
  CartRepository cartRepository;

  //TODO: get COUPON
  getCoupon(String coupon) {
    emit(CouponLoadingState());
    cartRepository.getCouponRepository(coupon).then((value) {
      emit(CouponSuccessState(genericModel: value));
    }).catchError((e) {
      emit(CouponErrorState(e.toString()));
    });
  }
}
