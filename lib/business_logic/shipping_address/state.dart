import 'package:resort_store/data/model/shipping_address/shipping_address.dart';

abstract class ShippingAddressStates {}

class ShippingAddressInitState extends ShippingAddressStates {}

class ShippingAddressSuccessState extends ShippingAddressStates {
  final ShippingAddressModel shippingAddressModel;
  ShippingAddressSuccessState({required this.shippingAddressModel});
}

// class AddressSuccessState extends ShippingAddressStates {
//   final ShippingAddressModel shippingAddressModel;
//   AddressSuccessState({required this.shippingAddressModel});
// }

class ShippingAddressLoadingState extends ShippingAddressStates {}

class ShippingAddressErrorState extends ShippingAddressStates {
  String? e;

  ShippingAddressErrorState(this.e);
}
