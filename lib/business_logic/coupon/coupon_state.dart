part of 'coupon_cubit.dart';

@immutable
abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponLoadingState extends CouponState {}

class CouponErrorState extends CouponState {
  final String error;

  CouponErrorState(this.error);
}

class CouponSuccessState extends CouponState {
  final GenericModel genericModel;

  CouponSuccessState({required this.genericModel});
}
