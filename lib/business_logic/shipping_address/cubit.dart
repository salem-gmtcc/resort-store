import 'package:resort_store/business_logic/shipping_address/state.dart';
import 'package:resort_store/data/repository/shipping_address/shipping_address.dart';
import 'package:bloc/bloc.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressStates> {
  ShippingAddressCubit({required this.shippingAddressRepository})
      : super(ShippingAddressInitState());
  final ShippingAddressRepository shippingAddressRepository;

  //TODO: get Shipping Address
  getShippingAddressCubit(Map<String, dynamic> body) {
    emit(ShippingAddressLoadingState());
    shippingAddressRepository.getShippingAddressRepository(body).then((value) {
      emit(ShippingAddressSuccessState(shippingAddressModel: value));
    }).catchError((e) {
      emit(ShippingAddressErrorState(e.toString()));
    });
  }

  //TODO: get All Address
  getAllAddressCubit() {
    emit(ShippingAddressLoadingState());
    shippingAddressRepository.getAddressRepository().then((value) {
      emit(ShippingAddressSuccessState(shippingAddressModel: value));
    }).catchError((e) {
      emit(ShippingAddressErrorState(e.toString()));
    });
  }
}
